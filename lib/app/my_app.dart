 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/router/app_router.dart';
import 'package:news_app/config/theme/themes.dart';
import 'package:news_app/core/utils/App_strings.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => current is ThemeState,
          builder: (context, state) {
            final isDarkMode = context.read<HomeCubit>().getCurrentTheme() == AppThemeMode.dark;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
              initialRoute: Routes.splashRoute,
              onGenerateRoute: AppRoutes.onGenerateRoute,
            );
          },
        );
      },
    );
  }
}