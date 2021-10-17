import 'package:drift/drift.dart';
import 'package:flutter_newsfeed/models/db/database.dart';

part 'dao.g.dart';

@DriftAccessor(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDatabase> with _$NewsDaoMixin {
  NewsDao(MyDatabase db) : super(db);
}
