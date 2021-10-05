import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/search_type.dart';

class NewsListViewModel extends ChangeNotifier {
  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) {
    // TODO
    print("searchType: $searchType / keyword: $keyword / category: $category");
  }
}
