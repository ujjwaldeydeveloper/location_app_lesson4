import 'package:flutter/material.dart';
import 'models/location.dart';
import 'utills/style.dart';

class LocationList extends StatelessWidget {
  final List<Location> location;

  const LocationList(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: Style.hearderLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: location.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: _itemThumbnail(location[index]),
            title: _itemTitle(location[index]),
          );
        },
      ),
    );
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: Image.network(
        location.url,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _itemTitle(Location location){
    return Text(
      location.name,
      style:  Style.textDefault,

    );
  }
}
