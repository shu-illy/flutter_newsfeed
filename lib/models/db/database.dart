import 'package:drift/drift.dart';

part 'database.g.dart';

class ArticleRecords extends Table {
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [ArticleRecords])
class MyDatabase {}
