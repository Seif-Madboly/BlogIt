import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/my_app.dart';
import 'package:news_app/core/api/api_services.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final newsService = NewsService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            sharedPreferences: sharedPreferences,
            newsService: newsService
          )
        )
      ],
      child: const MyApp(),
    ),
  );
}