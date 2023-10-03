import 'dart:convert';
import 'package:test/test.dart';
import '../../lib/models/location.dart';

void main() {
  test('test location deserialization', () {
    const locationJSON = {
      "name": 'Arashiyama Bamboo Grove',
      "url":
          'https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg',
      "facts": [
        {
          "title": 'Summary',
          "text":
              'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm',
        },
        {
          "title": 'How to Get There',
          "text":
              'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.',
        }
      ]
    };

    final locationMap =  json.decode(locationJSON as String) as Map<String, dynamic>;

    expect('Arashiyama Bamboo Grove', equals(locationMap["name"]));

    final location = Location.fromJson(locationJSON);
    expect(location.name, equals(locationMap['name']));
    expect(location.url, equals(locationMap['url']));
  });
}
