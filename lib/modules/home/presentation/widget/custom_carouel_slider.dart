 import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_assets.dart';


import 'package:news_app/modules/home/data/model/articles_model.dart';

class CustomCarouelSlider extends StatelessWidget {
  final List<ArticlesModel>? articles;

  const CustomCarouelSlider({super.key, this.articles});

  @override
  Widget build(BuildContext context) {
     final List<ArticlesModel> itemsToShow = articles ?? [];

    if (itemsToShow.isEmpty) {
      return Container(
        height: 220.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: const DecorationImage(
            image: AssetImage(AppImageAssets.news),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "No featured stories available",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return CarouselSlider(
      items: itemsToShow.map((article) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Stack(
                children: [
                   ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: article.urlToImage.isNotEmpty
                        ? Image.network(
                            article.urlToImage,
                            height: 220.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, error, _) => Image.asset(
                              AppImageAssets.news,
                              height: 220.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            AppImageAssets.news,
                            height: 220.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient:const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                    child: Text(
                      article.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 220.0.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
    );
  }
}