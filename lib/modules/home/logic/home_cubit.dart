import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/core/api/api_services.dart';
import 'package:news_app/modules/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  final SharedPreferences sharedPreferences;
  final NewsService newsService;
  AppThemeMode currentTheme = AppThemeMode.light;
  StreamSubscription? _connectivitySubscription;

   static const String themeKey = 'themeMode';

  HomeCubit({required this.sharedPreferences, required this.newsService})
      : super(const InitialState()) {
    _loadThemePreferences();
    _initializeConnectivityListener();
  }


  void toggleTheme() {
    currentTheme = currentTheme == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    _saveThemePreferences();
    emit(ThemeState(currentTheme));
  }

  AppThemeMode getCurrentTheme() => currentTheme;

  void _saveThemePreferences() {
    sharedPreferences.setInt(themeKey, currentTheme.index);
  }

  void _loadThemePreferences() {
    final storedTheme = sharedPreferences.getInt(themeKey);
    if (storedTheme != null && storedTheme < AppThemeMode.values.length) {
      currentTheme = AppThemeMode.values[storedTheme];
      emit(ThemeState(currentTheme));
    } else {
      emit(ThemeState(currentTheme));
    }
  }


  void _initializeConnectivityListener() async {
     final connectivityResult = await Connectivity().checkConnectivity();
    _handleConnectivityChange(connectivityResult);

     _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile)) {
      emit(const ConnectedState(message: "Connected"));

       if (state is NotConnectedState) {
        fetchNews(category: 'general');
      }
    } else {
      emit(const NotConnectedState(message: "No internet connection"));
    }
  }


  Future<void> fetchNews({required String category}) async {
     if (state is NotConnectedState) {
      return;
    }

    emit(NewsLoading());

    try {
      final articles = await newsService.getNews(category: category);
      if (articles.isEmpty) {
        emit(NewsEmpty(category: category));
      } else {
        emit(NewsSuccess(articles));
      }
    } catch (e) {
      emit(NewsFailure(
        error: e.toString(),
        errorType: e.toString().contains("internet") ? "network" : "api",
      ));
    }
  }
Future<void> getSearch({required String searchText}) async {
  if (searchText.isEmpty) {
     return fetchNews(category: 'general');
  }

  emit(SearchLoadingState());

  try {
    final articles = await newsService.getSearchNews(searchText);
    if (articles.isEmpty) {
      emit(const SearchFailureState(error: "No search results found"));
    } else {
      emit(SearchSuccessState(articles));
    }
  } catch (e) {
    emit(SearchFailureState(
      error: e.toString(),
      errorType: e.toString().contains("internet") ? "network" : "api",
    ));
  }
}

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
