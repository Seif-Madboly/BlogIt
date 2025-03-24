import 'package:flutter/material.dart';
import 'package:news_app/config/router/app_router.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/media_query_values.dart';
import 'package:news_app/modules/onboarding/data/model/on_boarding_model.dart';
import 'package:news_app/modules/onboarding/presentation/widget/custom_dots.dart';
import 'package:news_app/modules/onboarding/presentation/widget/custom_onboarding_button.dart';
import 'package:news_app/modules/onboarding/presentation/widget/on_boarding_item_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isNavigating = false;
  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboarding.length,
                itemBuilder: (context, i) {
                  return OnBoardingItemWidget(
                      index: i, height: height, width: width);
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding.length,
                      (int index) =>
                          CustomDots(currentPage: _currentPage, index: index),
                    ),
                  ),
                  _currentPage + 1 == onboarding.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: CustomOnBoardingButton(
                            onPress: () {
                              if (isNavigating) {
                                return; // Prevent multiple navigations
                              }
                              isNavigating = true;
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.loginRoute,
                                (route) => false,
                              ).then((_) => isNavigating =
                                  false); // Reset the flag after navigation
                            },
                            text: "START",
                            backgroundColor: AppColors.primaryColor,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 20)
                                : EdgeInsets.symmetric(
                                    horizontal: width * 0.2, vertical: 25),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              CustomOnBoardingButton(
                                onPress: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                text: "NEXT",
                                backgroundColor: AppColors.primaryColor,
                                padding: (width <= 550)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 25),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
