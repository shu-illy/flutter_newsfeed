import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/search_type.dart';

class NewsRepository {
  Future<void> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    // TODO
    print(
        "[Repository] searchType: $searchType / keyword: $keyword / category: ${category?.nameJp}");
  }
}
