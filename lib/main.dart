import 'package:flutter/material.dart';
import 'package:lesson4/location_list.dart';
import 'models/location.dart';
import 'location_detail.dart';
import 'mocks/mock_location.dart';

void main() {
  final List<Location> mockLocation = MockLocation.fetchAll();

  return runApp(MaterialApp(home: LocationList(mockLocation)));
}
