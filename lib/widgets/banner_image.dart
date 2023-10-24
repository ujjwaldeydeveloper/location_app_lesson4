import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final String url;
  final double height;
  const BannerImage(this.url, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.tightFor(
            height: height, width: MediaQuery.of(context).size.width),
        child: Image.network(url, fit: BoxFit.cover),
      );
    } catch (e) {
      return Container();
    }
  }
}
