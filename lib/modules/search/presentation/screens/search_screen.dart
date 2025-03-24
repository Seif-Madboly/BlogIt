import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';
import 'package:news_app/modules/home/presentation/widget/custom_list_tile.dart';
import 'package:news_app/modules/news_details/presentation/screens/news_details_screen.dart';
import 'package:news_app/modules/search/presentation/widget/search_failure_widget.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getSearch(searchText: widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SearchFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
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
          appBar: AppBar(
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            title: Text(
              widget.searchQuery,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18.sp,
              ),
            ),
            iconTheme: IconThemeData(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          body: _buildBody(state, isDarkMode),
        );
      },
    );
  }

  Widget _buildBody(HomeState state, bool isDarkMode) {
    if (state is SearchLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SearchFailureState) {
      return SearchFailure(
        isDarkMode: isDarkMode,
        text: "No results found for '${widget.searchQuery}'",
        onPressed: () =>
            context.read<HomeCubit>().getSearch(searchText: widget.searchQuery),
      );
    }

    if (state is SearchSuccessState) {
      final articles = state.articles;

      if (articles.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                "No results found for '${widget.searchQuery}'",
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
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
      );
    }

    // Default empty state
    return Center(
      child: Text(
        "Enter a search term",
        style: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }
}
