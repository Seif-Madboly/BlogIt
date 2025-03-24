import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/config/router/app_router.dart';
import 'package:news_app/modules/splash/presentation/widget/app_logo_widget.dart';
import 'package:news_app/modules/splash/presentation/widget/custom_animated_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.onboardingRoute,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppLogoWidget(), CustomAnimatedText()],
        ),
      ),
    );
  }
}