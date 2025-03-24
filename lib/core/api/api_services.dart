
import 'dart:convert';
  import 'package:news_app/modules/home/data/model/articles_model.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status code: $statusCode)';
    }
    return 'ApiException: $message';
  }
}

class NewsService {
  final String baseUrl = "https://newsapi.org/v2/top-headlines/";
  final String apiKey = "ae0b81e9f1c242ddadee71855e12ad1f";
  final String country = "us";

  // Dependency injection for testing
  final http.Client _client;

  NewsService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<ArticlesModel>> getNews({required String category}) async {
    try {
      final queryParams = {
         'country': country,
        'category': category,
        'apiKey': apiKey,
      };

      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      final response = await _client.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw ApiException('Request timeout'),
      );

      if (response.statusCode != 200) {
        Map<String, dynamic>? errorData;
        try {
          errorData = jsonDecode(response.body);
        } catch (_) {
          // JSON parsing failed
        }

        final errorMessage = errorData?['message'] ?? 'Unknown error';
        throw ApiException(errorMessage, statusCode: response.statusCode);
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (!data.containsKey("articles") || data["articles"] == null) {
        return [];
      }

      final List<dynamic> articlesJson = data["articles"];

      return articlesJson
          .map((articleJson) => ArticlesModel.fromJson(articleJson))
          .toList();
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(e.toString());
    }

  }

Future<List<ArticlesModel>> getSearchNews(String searchText) async {
  try {
    final queryParams = {
      'q': searchText,
      'apiKey': apiKey,
    };

    final uri = Uri.parse("https://newsapi.org/v2/everything").replace(queryParameters: queryParams);

    final response = await _client.get(uri).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw ApiException('Request timeout'),
    );

    if (response.statusCode != 200) {
      Map<String, dynamic>? errorData;
      try {
        errorData = jsonDecode(response.body);
      } catch (_) {
        // JSON parsing failed
      }

      final errorMessage = errorData?['message'] ?? 'Unknown error';
      throw ApiException(errorMessage, statusCode: response.statusCode);
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (!data.containsKey("articles") || data["articles"] == null) {
      return [];
    }

    final List<dynamic> articlesJson = data["articles"];

    return articlesJson
        .map((articleJson) => ArticlesModel.fromJson(articleJson))
        .toList();
  } catch (e) {
    if (e is ApiException) {
      rethrow;
    }
    throw ApiException(e.toString());
  }
}
   
}