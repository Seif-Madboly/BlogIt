import 'package:flutter/cupertino.dart';
import 'package:news_app/modules/home/presentation/screens/home_screen.dart';

import 'package:news_app/modules/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:news_app/modules/registration/presentation/screens/login_screen.dart';
import 'package:news_app/modules/registration/presentation/screens/singup_screen.dart';
import 'package:news_app/modules/splash/presentation/screen/splash_screen.dart';

class Routes {
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/sign-up';
  static const String homeRoute = '/home';

}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    debugPrint('Navigating to: ${routeSettings.name}'); // Debug statement

    switch (routeSettings.name) {
      case Routes.splashRoute:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
          settings: routeSettings,
        );
      case Routes.onboardingRoute:
        return CupertinoPageRoute(
          builder: (_) => const OnBoardingScreen(),
          settings: routeSettings,
        );
      case Routes.loginRoute:
        return CupertinoPageRoute(
          builder: (_) => LoginScreen(),
          settings: routeSettings,
        );
      case Routes.signUpRoute:
        return CupertinoPageRoute(
          builder: (_) => SingupScreen(),
          settings: routeSettings,
        );
      case Routes.homeRoute:
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
          settings: routeSettings,
        );
     
    }
    return null;
  }
}
