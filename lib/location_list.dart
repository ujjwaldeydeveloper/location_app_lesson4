import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lesson4/location_detail.dart';
import 'package:lesson4/widgets/banner_image.dart';
import 'package:lesson4/widgets/default_app_bar.dart';
import 'package:lesson4/widgets/location_tile.dart';
import 'netword_services/api_service.dart';
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
        final locations = await ApiService.fetchAll();
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
      appBar: DefaultAppBar(),
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
    return GestureDetector(
      onTap: () => _navigationToLocationDetails(context, location.id),
      child: Container(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            BannerImage(location.url, MediaQuery.of(context).size.height * 0.3),
            _tileFooter(location)
          ],
        ),
      ),
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

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);
    final overlay = Container(
      height: 80.0,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }
}
