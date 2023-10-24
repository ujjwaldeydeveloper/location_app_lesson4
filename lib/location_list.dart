import 'package:flutter/material.dart';
import 'package:lesson4/location_detail.dart';
import 'models/location.dart';
import 'utills/style.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
    print("CR-> intistate ${locations}");
  }

  loadData() async {
    final locations = await Location.fetchAll();
    print("loadData locations $locations");
    if (this.mounted) {
      setState(() {
        this.locations = locations;
      });
    }
  }

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
        itemCount: locations.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigationToLocationDetails(context, location.id),
    );
  }

  void _navigationToLocationDetails(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationDetail(index),
      ),
    );
  }

  Widget _itemThumbnail(Location location) {
    if (location.url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.tightFor(height: 100.0),
        child: Image.network(location.url, fit: BoxFit.fitWidth),
      );
    } catch (e) {
      print("could not load image ${location.url}");
      return Container();
    }
  }

  Widget _itemTitle(Location location) {
    return Text(
      location.name,
      style: Style.textDefault,
    );
  }
}
