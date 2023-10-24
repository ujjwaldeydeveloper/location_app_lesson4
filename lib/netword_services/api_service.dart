import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/location.dart';
import 'endpoint.dart';

class ApiService {
  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/fake_api/users', queryParameters: {});

    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw (response.body);
    }

    List<Location> list = <Location>[];
    for (var jsonItem in json.decode(response.body)) {
      list.add(Location.fromJson(jsonItem));
    }

    return list;
  }

  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/fake_api/users/$id', queryParameters: {});

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap);
  }
}
