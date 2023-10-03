import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:lesson4/endpoint.dart';
import './location_fact.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact> facts;
  Location({
    required this.id,
    required this.name,
    required this.url,
    required this.facts,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> futureFetchAll() async {

    var uri = Endpoint.uri('location_api/items', queryParameters: {});

    final response = await http.get(uri);

    if(response.statusCode != HttpStatus.ok) {
      throw(response.body);
    }

    List<Location> list = <Location>[];
    for(var jsonItem in json.decode(response.body)) {
      list.add(Location.fromJson(jsonItem));
    }

    return list;
  }

   static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/location_api/items/$id', queryParameters: {});

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap);
  }

}
