import 'dart:async';

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
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() => loading = true);
      Timer(const Duration(milliseconds: 4000), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          loading = false;
        });
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
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Column(
          children: [
            renderProgressBar(context),
            Expanded(child: renderListView(context)),
          ],
        ),
      ),
    );
  }

  Widget renderProgressBar(BuildContext context) {
    return loading
        ? const LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )
        : Container();
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = locations[index];
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
        constraints: const BoxConstraints.tightFor(height: 100.0, width: 120),
        child: Image.network(location.url, fit: BoxFit.fitWidth),
      );
    } catch (e) {
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
