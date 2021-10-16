import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/viewmodels/head_line_view_model.dart';
import 'package:flutter_newsfeed/viewmodels/news_list_view_model.dart';
import 'package:provider/provider.dart';

import 'view/screens/home_screen.dart';
import 'view/style/style.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewsListViewModel()),
      ChangeNotifierProvider(create: (_) => HeadLineViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
