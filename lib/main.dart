import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/di/providers.dart';
import 'package:provider/provider.dart';

import 'view/screens/home_screen.dart';
import 'view/style/style.dart';

void main() {
  runApp(MultiProvider(
    providers: globalProviders,
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
