import 'package:flutter/material.dart';
import 'package:lesson4/location_list.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    // final List<Location> mockLocation = MockLocation.fetchAll();
    return const MaterialApp(home: LocationList());
  }
}
