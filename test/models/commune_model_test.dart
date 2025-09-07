import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';

void main() {
  group('Commune Model Tests', () {
    test('should create Commune from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'pachalik-circon': 'Test Pachalik',
        'caidat': 'Test Caidat',
        'nom': 'Test Commune',
        'latitude': '33.5731',
        'longitude': '-7.5898',
      };

      // Act
      final commune = Commune.fromJson(json);

      // Assert
      expect(commune.id, 1);
      expect(commune.pachalikcircon, 'Test Pachalik');
      expect(commune.caidat, 'Test Caidat');
      expect(commune.nom, 'Test Commune');
      expect(commune.latitude, 33.5731);
      expect(commune.longitude, -7.5898);
    });

    test('should convert Commune to JSON correctly', () {
      // Arrange
      final commune = Commune(
        id: 1,
        pachalikcircon: 'Test Pachalik',
        caidat: 'Test Caidat',
        nom: 'Test Commune',
        latitude: 33.5731,
        longitude: -7.5898,
      );

      // Act
      final json = commune.toJson();

      // Assert
      expect(json['pachalik-circon'], 'Test Pachalik');
      expect(json['caidat'], 'Test Caidat');
      expect(json['nom'], 'Test Commune');
      expect(json['latitude'], 33.5731);
      expect(json['longitude'], -7.5898);
      expect(json.containsKey('id'), false); // ID should not be in toJson
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'pachalik-circon': 'Test Pachalik',
        'caidat': 'Test Caidat',
        'nom': 'Test Commune',
        'latitude': '33.5731',
        'longitude': '-7.5898',
      };

      // Act
      final commune = Commune.fromJson(json);

      // Assert
      expect(commune.id, null);
      expect(commune.pachalikcircon, 'Test Pachalik');
      expect(commune.caidat, 'Test Caidat');
      expect(commune.nom, 'Test Commune');
      expect(commune.latitude, 33.5731);
      expect(commune.longitude, -7.5898);
    });

    test('should handle numeric latitude/longitude in JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'pachalik-circon': 'Test Pachalik',
        'caidat': 'Test Caidat',
        'nom': 'Test Commune',
        'latitude': 33.5731,
        'longitude': -7.5898,
      };

      // Act
      final commune = Commune.fromJson(json);

      // Assert
      expect(commune.latitude, 33.5731);
      expect(commune.longitude, -7.5898);
    });
  });
}
