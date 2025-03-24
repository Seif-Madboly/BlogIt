import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/widgets/error_screen.dart';
import 'package:news_app/core/widgets/no_connection.dart';
import 'package:news_app/modules/home/data/model/articles_model.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';
import 'package:news_app/modules/home/presentation/widget/custom_app_bar.dart';
import 'package:news_app/modules/home/presentation/widget/custom_carouel_slider.dart';
import 'package:news_app/modules/home/presentation/widget/custom_headline.dart';
import 'package:news_app/modules/home/presentation/widget/custom_list_tile.dart';
import 'package:news_app/modules/home/presentation/widget/custom_tab_bar.dart';
import 'package:news_app/modules/news_details/presentation/screens/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final List<String> categories = ['general', 'business', 'science', 'sports'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Fetch initial news
    _fetchCurrentTabNews();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      _fetchCurrentTabNews();
    }
  }

  void _fetchCurrentTabNews() {
    final category = categories[_tabController.index];
    context.read<HomeCubit>().fetchNews(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NewsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Something went wrong!",
             
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is NotConnectedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final HomeCubit cubit = context.read<HomeCubit>();
        final bool isDarkMode = cubit.getCurrentTheme() == AppThemeMode.dark;

        return Scaffold(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          body: _buildBody(state, isDarkMode),
        );
      },
    );
  }

  Widget _buildBody(HomeState state, bool isDarkMode) {
    // Handle connection state
    if (state is NotConnectedState) {
      return const NoConnection();
    }

    // Handle loading state
    if (state is NewsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Handle error state
    if (state is NewsFailure) {
      return ErrorScreen(
        color: isDarkMode ? Colors.white : Colors.black,
        onPressed: _fetchCurrentTabNews,
        text: "Something went wrong!",

      );
    }

    return _buildNewsScreen(state, isDarkMode);
  }

  Widget _buildNewsScreen(HomeState state, bool isDarkMode) {
    final List<ArticlesModel> articles =
        state is NewsSuccess ? state.articles : [];
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          CustomAppBar(
            isDarkMode: isDarkMode,
            searchController: searchController,
            onPressed: context.read<HomeCubit>().toggleTheme,
          )
        ];
      },
      body: Container(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          child: Column(
            children: [
              CustomTabBar(
                isDarkMode: isDarkMode,
                controller: _tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: categories.map((_) {
                    return _buildNewsContent(articles, isDarkMode, state);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildNewsContent(
    List<ArticlesModel> articles, bool isDarkMode, HomeState state) {
  // Handle empty news
  if (state is NewsEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper,
            size: 48,
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "No news available for ${state.category}",
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchCurrentTabNews,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  // Handle no articles
  if (articles.isEmpty) {
    return Center(
      child: ElevatedButton(
        onPressed: _fetchCurrentTabNews,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        child: const Text('Load News'),
      ),
    );
  }

  // Important: Wrap in SingleChildScrollView with AlwaysScrollableScrollPhysics
  return RefreshIndicator(
    onRefresh: () async {
      return await context.read<HomeCubit>().fetchNews(
          category: categories[_tabController.index]);
    },
    child: ListView(
       physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeadline(text: "Featured Stories"),
            CustomCarouelSlider(articles: articles.take(5).toList()),
            SizedBox(height: 10.h),
            const CustomHeadline(text: "Breaking News"),
          ],
        ),
        ...List.generate(
          articles.length,
          (index) {
            final article = articles[index];
            return CustomListTile(
              image: article.urlToImage,
              titleColor: isDarkMode ? Colors.white : Colors.black,
              subtitleColor: isDarkMode ? Colors.white : Colors.black,
              title: article.title,
              publishedAt: article.publishedAt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailsScreen(
                      image: article.urlToImage,
                      title: article.title,
                      subtitle: article.description,
                      publishedAt: article.publishedAt,
                      link: article.url,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );
}
}
