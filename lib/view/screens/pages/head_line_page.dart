import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/data/search_type.dart';
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
          // TODO
          body: Container(
            child: Center(
              child: Text('Headlihne Page'),
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
}
