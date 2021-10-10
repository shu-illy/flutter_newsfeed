import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  static const BASE_URL = 'https://newsapi.org/v2/top-headlines?country=jp';
  static const API_KEY = 'b8cf218454144da9b4e26ec3d08c7bca';

  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    List<Article> result = [];

    http.Response? response;
    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse("$BASE_URL&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KEYWORD:
        final requestUrl = Uri.parse("$BASE_URL&q=$keyword&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl =
            Uri.parse("$BASE_URL&category=${category?.nameEn}&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }

    return result;
  }
}
