import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;

  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // URLがスキーム(https:などを含まない場合があるので、対応する処理
    final isValidUrl =
        (imageUrl == null) ? false : imageUrl!.startsWith("http");
    final primaryColor = Theme.of(context).primaryColor;
    if (imageUrl == null || imageUrl == '' || !isValidUrl) {
      return const Icon(Icons.broken_image);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        )),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
        fit: BoxFit.cover,
      );
    }
  }
}
