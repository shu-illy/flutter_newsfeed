import 'package:flutter/material.dart';

import 'view/screens/home_screen.dart';
import 'view/style/style.dart';

void main() => runApp(MyApp());

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
