import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/load_status.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';
import 'package:flutter_newsfeed/view/components/head_line_item.dart';
import 'package:flutter_newsfeed/view/components/page_transformer.dart';
import 'package:flutter_newsfeed/viewmodels/head_line_view_model.dart';
import 'package:provider/provider.dart';

import '../news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();
    // final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // と同じ

    if (viewModel.loadStatus != LoadStatus.LOADING &&
        viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<HeadLineViewModel>(
              builder: (context, model, child) {
                if (model.loadStatus == LoadStatus.LOADING) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return PageTransformer(
                    pageViewBuilder: (context, pageVisibilityResolver) {
                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount: model.articles.length,
                        itemBuilder: (context, index) {
                          final article = model.articles[index];
                          final pageVisibility = pageVisibilityResolver
                              .resolvePageVisibility(index);
                          // final visibleFraction = pageVisibility.visibleFraction;
                          return HeadLineItem(
                            article: article,
                            pageVisibility: pageVisibility,
                            onArticleClicked: (article) =>
                                _openArticleWebPage(context, article),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => onRefresh(context),
          )),
    );
  }

  // TODO 更新処理
  onRefresh(BuildContext context) async {
    print('HeadLinePage.onRefresh');
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(BuildContext context, Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
