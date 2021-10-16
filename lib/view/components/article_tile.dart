import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/models/model/news_model.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  // ValueChanged: 名前付きコールバック
  final ValueChanged onArticleClicked;

  const ArticleTile({required this.article, required this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () => onArticleClicked(article),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    // TODO
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    // TODO
                    child: Column(children: <Widget>[
                      Text(article.title ?? ""),
                      Text(article.publishDate ?? ""),
                      Text(article.description ?? "")
                    ]),
                  )
                ],
              )),
        ));
  }
}
