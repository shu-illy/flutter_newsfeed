import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/models/db/dao.dart';
import 'package:flutter_newsfeed/models/db/database.dart';
import 'package:flutter_newsfeed/models/repository/news_repository.dart';
import 'package:flutter_newsfeed/viewmodels/head_line_view_model.dart';
import 'package:flutter_newsfeed/viewmodels/news_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<MyDatabase>(
    create: (_) => MyDatabase(),
    dispose: (_, db) => db.close(),
  )
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
      dao: context.read<NewsDao>(),
    ),
  ),
  // ProxyProvider<NewsDao, NewsRepository>(
  //   update: (_, dao, repository) => NewsRepository(dao: dao),
  // ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<NewsRepository, HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      repository: context.read<NewsRepository>(),
    ),
    update: (context, repository, viewModel) =>
        viewModel!..onRepositoryUpdated(repository),
  ),
  ChangeNotifierProxyProvider<NewsRepository, NewsListViewModel>(
    create: (context) => NewsListViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
        viewModel!..onRepositoryUpdated(repository),
  ),
];
