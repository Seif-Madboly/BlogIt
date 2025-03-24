// import 'package:news_app/modules/home/data/model/articles_model.dart';

// enum AppThemeMode { dark, light }

// abstract class HomeState {}

// class ThemeState extends HomeState {
//   final AppThemeMode themeMode;

//   ThemeState(this.themeMode);
// }

// class NewsLoading extends HomeState {}

// class NewsSuccess extends HomeState {
//   final List<ArticlesModel> articles;
//   NewsSuccess(this.articles);
// }

// class NewsFailure extends HomeState {
//   final String error;
//   final String errorType;
//   NewsFailure(this.error, {this.errorType = "api"});
// }

// class ConnectedState extends HomeState {
//   final String message;
//   ConnectedState({required this.message});
// }

// class NotConnectedState extends HomeState {
//   final String message;
//   NotConnectedState({required this.message});
// }


import 'package:equatable/equatable.dart';
import 'package:news_app/modules/home/data/model/articles_model.dart';

enum AppThemeMode { dark, light }

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// Initial state when app starts
class InitialState extends HomeState {
  const InitialState();
}

// Theme state
class ThemeState extends HomeState {
  final AppThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

// News loading state
class NewsLoading extends HomeState {}

// News success state
class NewsSuccess extends HomeState {
  final List<ArticlesModel> articles;

  const NewsSuccess(this.articles);

  @override
  List<Object?> get props => [articles];
}

// News empty state (when API returns successfully but with no articles)
class NewsEmpty extends HomeState {
  final String category;

  const NewsEmpty({required this.category});

  @override
  List<Object?> get props => [category];
}

// News failure state
class NewsFailure extends HomeState {
  final String error;
  final String errorType;

  const NewsFailure({
    required this.error,
    this.errorType = "api",
  });

  @override
  List<Object?> get props => [error, errorType];
}

// Connectivity states
class ConnectedState extends HomeState {
  final String message;

  const ConnectedState({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotConnectedState extends HomeState {
  final String message;

  const NotConnectedState({required this.message});

  @override
  List<Object?> get props => [message];
}
 
class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {
  final List<ArticlesModel> articles;

  const SearchSuccessState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class SearchFailureState extends HomeState {
  final String error;
  final String errorType;

  const SearchFailureState({
    required this.error,
    this.errorType = "api",
  });

  @override
  List<Object?> get props => [error, errorType];
}