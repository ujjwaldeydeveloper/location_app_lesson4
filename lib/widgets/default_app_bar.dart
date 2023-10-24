import 'package:flutter/material.dart';

import '../utills/style.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({super.key});

  @override
  final Widget title =
      Text("Tourism & Co.".toUpperCase(), style: Style.navBarTitle);

  @override
  final IconThemeData iconTheme = const IconThemeData(color: Colors.black);

  @override
  final Color backgroundColor = Colors.white;

  // @override
  // final Color foregroundColor = Colors.white;

  // @override
  // final Color surfaceTintColor = Colors.white;

  @override
  final bool centerTitle = true;

  @override
  final double elevation = 0.5;
}
