import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';
import 'package:flutter_newsfeed/view/style/style.dart';

class ArticleTileDescription extends StatelessWidget {
  final Article article;

  const ArticleTileDescription({required this.article});

  @override
  Widget build(BuildContext context) {
    // このコンテキストで使っているテーマのtextTheme
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          article.title ?? "",
          style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          article.publishDate ?? "",
          style: textTheme.overline?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(article.description ?? "",
            style: textTheme.bodyText1?.copyWith(fontFamily: RegularFont))
      ],
    );
  }
}
