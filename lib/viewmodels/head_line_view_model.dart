import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';
import 'package:flutter_newsfeed/models/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _repository;

  HeadLineViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  Future<void> getHeadLines({required SearchType searchType}) async {
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();
    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);
    print("searchType: $_searchType / articles: ${_articles[0].title}");
    _isLoading = false;
    notifyListeners();
  }

  // TODO
  onRepositoryUpdated(NewsRepository repository) {}
}
