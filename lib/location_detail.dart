import 'package:flutter/material.dart';
import 'package:lesson4/widgets/banner_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/location.dart';
import 'netword_services/api_service.dart';
import 'utills/style.dart';
import 'widgets/default_app_bar.dart';
import 'widgets/location_tile.dart';

const BannerImageHeight = 300.0;
const BodyVerticalPadding = 20.0;
const FooterHeight = 100.0;

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
    final location = await ApiService.fetchByID(locationID);

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
        body: Stack(
          children: [
            _renderBody(context, location),
            _renderFooter(context, location),
          ],
        ));
  }

  Widget _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(BannerImage(location.url, BannerImageHeight));
    result.add(_renderHeader());
    result.addAll(_renderFacts(context, location));
    result.add(_renderBottomSpace());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: result,
      ),
    );
  }

  Widget _renderHeader() {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: BodyVerticalPadding,
            horizontal: Style.horizontalPaddingDefault),
        child: LocationTile(location: this.location, darkTheme: false));
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
            height: FooterHeight,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: _renderBookButton()),
          )
        ]);
  }

  Widget _renderBookButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Style.accentColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return Style.accentColor.withOpacity(0.04);
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed))
              return Style.accentColor.withOpacity(0.12);
            return null; // Defer to the widget's default.
          },
        ),
      ),
      // textColor: Style.textColorBright,
      onPressed: _handleBookPress,
      child: Text('Book'.toUpperCase(), style: Style.textCTAButton),
    );
  }

  void _handleBookPress() async {
    const url = 'mailto:hello@tourism.co?subject=inquiry';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
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

  Widget _renderBottomSpace() {
    return Container(
      height: FooterHeight,
    );
  }
}
