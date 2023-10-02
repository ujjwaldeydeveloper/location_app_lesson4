import 'package:flutter/material.dart';
import 'package:lesson4/location_detail.dart';
import 'models/location.dart';
import 'utills/style.dart';
import 'location_detail.dart';

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
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context,int index, ) {
    return ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: _itemThumbnail(location[index]),
          title: _itemTitle(location[index]),
          onTap: () => _navigationToLocationDetails(context, index),
        );
  }

  void _navigationToLocationDetails(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationDetail(location[index]),
      ),
    );
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 100.0),
      child: Image.network(
        location.url,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _itemTitle(Location location) {
    return Text(
      location.name,
      style: Style.textDefault,
    );
  }
}
