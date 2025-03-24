import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/core/utils/app_assets.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AppLottieAssets.noInternet,),
    );
  }
}
