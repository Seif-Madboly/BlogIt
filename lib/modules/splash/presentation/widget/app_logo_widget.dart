import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/App_assets.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImageAssets.appLogo,
     cacheHeight: 200.h.toInt(),
      cacheWidth: 200.w.toInt(),
      fit: BoxFit.contain,
    );
  }
}