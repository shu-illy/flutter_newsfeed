import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/category_info.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/view/components/article_tile.dart';
import 'package:flutter_newsfeed/view/components/category_chips.dart';
import 'package:flutter_newsfeed/view/components/search_bar.dart';
import 'package:flutter_newsfeed/view/screens/news_web_page_screen.dart';
import 'package:flutter_newsfeed/viewmodels/news_list_view_model.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categories[0]));
    }
    final primaryColor = Theme.of(context).primaryColor;
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
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    //
                    return model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, int position) => ArticleTile(
                              article: model.articles[position],
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
    print("NewsListPage.onRefresh");
  }

  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
    print("NewsListPage.getKeywordNews");
  }

  Future<void> getCategoryNews(BuildContext context, category) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
    print("NewsListPage.getCategoryNews / category: ${category?.nameJp}");
  }

  _openArticleWebPage(article, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
