
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/modules/onboarding/data/model/on_boarding_model.dart';

class OnBoardingItemWidget extends StatelessWidget {
  const OnBoardingItemWidget({
    super.key,
    required this.height,
    required this.width,
    required this.index,
  });

  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              onboarding[index].image,
             ),
          ),
          SizedBox(
            height: (height >= 840) ? 60 : 30,
          ),
          Text(
            onboarding[index].title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Mulish",
              fontWeight: FontWeight.w600,
              fontSize: (width <= 550) ? 30 : 35,
              color: AppColors.primaryColor
            ),
          ),
          const SizedBox(height: 15),
          Text(
            onboarding[index].description,
            style: TextStyle(
              fontFamily: "Mulish",
              fontWeight: FontWeight.w400,
              fontSize: (width <= 550) ? 17 : 25,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

