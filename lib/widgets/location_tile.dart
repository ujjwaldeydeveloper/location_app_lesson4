import 'package:flutter/material.dart';

import '../models/location.dart';
import '../utills/style.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final bool darkTheme;

  const LocationTile(
      {required this.location, required this.darkTheme, super.key});

  @override
  Widget build(BuildContext context) {
    final title = location.name.toUpperCase();
    final subTitle = location.user_itinerary_summary?.toUpperCase() ?? "";
    final caption = location.tour_package_name?.toUpperCase() ?? "";

    return Container(
      padding: EdgeInsets.all(0.0),
      height: 100.0,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: this.darkTheme
                    ? Style.locationTileTitleDark
                    : Style.locationTileTitleLight),
            Text('$subTitle', style: Style.locationTileSubTitle),
            Text('$caption', style: Style.locationTileCaption),
          ]),
    );
  }
}
