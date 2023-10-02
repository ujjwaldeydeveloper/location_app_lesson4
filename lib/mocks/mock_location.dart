import '../models/location.dart';
import '../models/location_fact.dart';
import 'package:http/http.dart' as http;

mixin MockLocation implements Location {
  static Location FetchAny() {
    return Location(
        name: 'Arashiyama Bamboo Grove, Kyoto, Japan',
        url: 'https://dpvr8cthj0mc3.cloudfront.net/flutter_testing.png',
        facts: <LocationFact>[
          LocationFact(
              title: 'Summary',
              text:
                  'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm'),
          LocationFact(
              title: 'How to Get There',
              text:
                  'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.')
        ]);
  }
}
