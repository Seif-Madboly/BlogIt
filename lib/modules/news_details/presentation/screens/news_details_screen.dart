import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/core/utils/app_assets.dart';
 import 'package:news_app/core/widgets/no_connection.dart';
import 'package:news_app/data/methods/string_to_date.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';
import 'package:news_app/modules/news_details/presentation/widget/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.publishedAt,
      required this.link});
  final String image;
  final String title;
  final String subtitle;
  final String publishedAt;
  final String link;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NotConnectedState) {
          Center(
            child: Lottie.asset(
              AppLottieAssets.noInternet,
            ),
          );
        }
      },
      builder: (context, state) {
        final HomeCubit cubit = context.read<HomeCubit>();
        final bool isDarkMode = cubit.getCurrentTheme() == AppThemeMode.dark;
        return Scaffold(
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            body: buildBody(context, state, isDarkMode));
      },
    );
  }

  Widget buildBody(BuildContext context, HomeState state, bool isDarkMode) {
    if (state is NotConnectedState) {
      return const NoConnection();
    } else if (state is NewsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NewsFailure) {
      return const Center(
        child: Text("ERROR 404"),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          leading: Container(
            height: 120.h,
            width: 170.w,
            margin: const EdgeInsets.only(top: 16, left: 16).r,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18).w),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          expandedHeight: 300.h,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(24).w,
                  bottomRight: const Radius.circular(24).w),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 3,
                  ),
                ),
                errorWidget: (context, url, error) =>   Image.asset(AppImageAssets.news)
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                CustomText(
                  text: title,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  letterSpacing: .5.w,
                  text: subtitle,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formateDate(publishedAt),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDarkMode ? Colors.white60 : Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CustomText(
                      letterSpacing: .5.w,
                      text: "Source:",
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 15.sp,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 200.w),
                      child: TextButton(
                        onPressed: () async {
                          try {
                            final Uri uri = Uri.parse(link);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Could not open link: $link'),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid URL: $link'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          link,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 13.sp,
                            textBaseline: TextBaseline.ideographic,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
