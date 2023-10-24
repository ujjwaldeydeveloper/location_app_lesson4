import 'package:flutter/material.dart';
import 'package:lesson4/widgets/banner_image.dart';
import 'models/location.dart';
import 'utills/style.dart';
import 'widgets/default_app_bar.dart';

class LocationDetail extends StatefulWidget {
  final int locationID;

  const LocationDetail(this.locationID, {super.key});

  @override
  State<LocationDetail> createState() => _LocationDetailState(locationID);
}

class _LocationDetailState extends State<LocationDetail> {
  final int locationID;
  Location location = Location.blank();

  _LocationDetailState(this.locationID);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final location = await Location.fetchByID(locationID);

    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _renderBody(context, location),
          ),
        ));
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(BannerImage(location.url, 170.0));
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    for (int i = 0; i < (location.facts?.length ?? 2); i++) {
      result.add(_sectionTitle(location.facts?[i].title ?? "default"));
      result.add(_sectionText(location.facts?[i].text ?? "default"));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: Style.hearderLarge,
        ));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Text(
          text,
          style: Style.textDefault,
        ));
  }
}
