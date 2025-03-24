// ignore_for_file: file_names

import 'package:flutter/material.dart';

const String imagePath = 'assets/images';
const String lottiePath = 'assets/lottie';
const String svgPath = 'assets/svg';


class AppImageAssets {
  const AppImageAssets._();

  static const AppImageAssets _instance = AppImageAssets._();

  factory AppImageAssets()=> _instance;

  static const String appLogo = '$imagePath/logo.png';
    static const String news = '$imagePath/news.jpeg';


}

class AppSvgAssets {
  const AppSvgAssets._();

  static const AppSvgAssets _instance = AppSvgAssets._();

  factory AppSvgAssets()=> _instance;

static const String onBoarding_1 = '$svgPath/on_boarding_1.svg';
  static const String onBoarding_2 = '$svgPath/on_boarding_2.svg';
  static const String onBoarding_3 = '$svgPath/on_boarding_3.svg';

}

class AppLottieAssets {
  const AppLottieAssets._();

  static const AppLottieAssets _instance = AppLottieAssets._();

  factory AppLottieAssets()=> _instance;

 
  static const String searchEmpty = '$lottiePath/search-empty.json';
   static const String noInternet = '$lottiePath/no_internet.json';


}



class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';

  static const IconData pill = IconData(
      0xea60, fontFamily: _kFontFam);
}