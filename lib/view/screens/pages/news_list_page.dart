import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/view/components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // TODO 検索ワード
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              // TODO: カテゴリー選択Chips
              // CategoryChips(),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// TODO: 記事更新処理
  onRefresh(BuildContext context) {
    print("NewsListPage.onRefresh");
  }

// TODO キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print("NewsListPage.getKeywordNews");
  }
}
