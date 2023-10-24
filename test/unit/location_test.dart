import 'package:test/test.dart';
import 'package:lesson4/netword_services/api_service.dart';

void main() {
  test('test /locations and /locations/:id', () async {
    final locations = await ApiService.fetchAll();
    for (var location in locations) {
      expect(location.id, greaterThan(0));
      expect(location.name, hasLength(greaterThan(0)));
      expect(location.url, hasLength(greaterThan(0)));

      final fetchedLocation = await ApiService.fetchByID(location.id);
      expect(fetchedLocation.name, equals(location.name));
      expect(fetchedLocation.url, equals(location.url));
      expect(fetchedLocation.facts, hasLength(greaterThan(0)));
    }
  });
}
