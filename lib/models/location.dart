import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import './location_fact.dart';
import '../netword_services/endpoint.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final String user_itinerary_summary;
  final String tour_package_name;
  final List<LocationFact>? facts;
  Location({
    required this.id,
    required this.name,
    required this.url,
    required this.user_itinerary_summary,
    required this.tour_package_name,
    required this.facts,
  });

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        facts = [],
        user_itinerary_summary = '',
        tour_package_name = '';

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
