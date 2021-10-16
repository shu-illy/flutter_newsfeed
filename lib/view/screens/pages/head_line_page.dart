import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
import 'package:flutter_newsfeed/view/components/page_transformer.dart';
import 'package:flutter_newsfeed/viewmodels/head_line_view_model.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();
    // final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // と同じ

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    return SafeArea(
      child: Scaffold(
          body: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              return PageTransformer(
                pageViewBuilder: (context, pageVisibilityResolver) {
                  return PageView.builder(
                    controller: PageController(),
                    itemCount: model.articles.length,
                    itemBuilder: (context, index) {
                      final article = model.articles[index];
                      final pageVisibility =
                          pageVisibilityResolver.resolvePageVisibility(index);
                      final visibleFraction = pageVisibility.visibleFraction;
                      return Opacity(
                        opacity: visibleFraction,
                        child: Container(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(article.title ?? ""),
                                Text(article.description ?? ""),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
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
}
