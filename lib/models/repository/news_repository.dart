import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/load_status.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/models/db/dao.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_newsfeed/util/extensions.dart';

class NewsRepository extends ChangeNotifier {
  static const BASE_URL = 'https://newsapi.org/v2/top-headlines?country=jp';
  static const API_KEY = 'b8cf218454144da9b4e26ec3d08c7bca';

  final NewsDao _dao;

  NewsRepository({dao}) : _dao = dao;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

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

    if (response.statusCode == 200) {
      //
      final responseBody = response.body;
      // results = News.fromJson(jsonDecode(responseBody)).articles;
      await insertAndReadFromDB(jsonDecode(responseBody));
      _loadStatus = LoadStatus.DONE;
    } else {
      _loadStatus = LoadStatus.ERROR;
      throw Exception('Failed to load news');
    }
    notifyListeners();
  }

  Future<void> insertAndReadFromDB(responseBody) async {
    final articlesFromNetwork = News.fromJson(responseBody).articles;

    // Webから取得した記事リスト(Dartのモデルクラス: Article)をDBのテーブルクラス(ArticleRecord)に変換してDB登録・DBから取得
    final articlesFromDB = await _dao.insertAndReadNewsFromDB(
        articlesFromNetwork.toArticleRecords(articlesFromNetwork));
    _articles = articlesFromDB.toArticles(articlesFromDB);
  }
}
