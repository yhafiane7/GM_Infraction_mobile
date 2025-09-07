import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';

void main() {
  group('Infraction Model Tests', () {
    test('should create Infraction from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Test Infraction',
        'date': '2024-01-01',
        'adresse': 'Test Address',
        'commune_id': '1',
        'violant_id': '1',
        'agent_id': '1',
        'categorie_id': '1',
        'latitude': '33.5731',
        'longitude': '-7.5898',
      };

      // Act
      final infraction = Infraction.fromJson(json);

      // Assert
      expect(infraction.id, 1);
      expect(infraction.nom, 'Test Infraction');
      expect(infraction.date, '2024-01-01');
      expect(infraction.adresse, 'Test Address');
      expect(infraction.commune_id, 1);
      expect(infraction.violant_id, 1);
      expect(infraction.agent_id, 1);
      expect(infraction.categorie_id, 1);
      expect(infraction.latitude, 33.5731);
      expect(infraction.longitude, -7.5898);
    });

    test('should convert Infraction to JSON correctly', () {
      // Arrange
      final infraction = Infraction(
        id: 1,
        nom: 'Test Infraction',
        date: '2024-01-01',
        adresse: 'Test Address',
        commune_id: 1,
        violant_id: 1,
        agent_id: 1,
        categorie_id: 1,
        latitude: 33.5731,
        longitude: -7.5898,
      );

      // Act
      final json = infraction.toJson();

      // Assert
      expect(json['id'], 1);
      expect(json['nom'], 'Test Infraction');
      expect(json['date'], '2024-01-01');
      expect(json['adresse'], 'Test Address');
      expect(json['commune_id'], '1');
      expect(json['violant_id'], '1');
      expect(json['agent_id'], '1');
      expect(json['categorie_id'], '1');
      expect(json['latitude'], '33.5731');
      expect(json['longitude'], '-7.5898');
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'nom': 'Test Infraction',
        'date': '2024-01-01',
        'adresse': 'Test Address',
        'commune_id': '1',
        'violant_id': '1',
        'agent_id': '1',
        'categorie_id': '1',
        'latitude': '33.5731',
        'longitude': '-7.5898',
      };

      // Act
      final infraction = Infraction.fromJson(json);

      // Assert
      expect(infraction.id, null);
      expect(infraction.nom, 'Test Infraction');
      expect(infraction.commune_id, 1);
    });

    test('should handle numeric IDs in JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Test Infraction',
        'date': '2024-01-01',
        'adresse': 'Test Address',
        'commune_id': 1,
        'violant_id': 1,
        'agent_id': 1,
        'categorie_id': 1,
        'latitude': 33.5731,
        'longitude': -7.5898,
      };

      // Act
      final infraction = Infraction.fromJson(json);

      // Assert
      expect(infraction.commune_id, 1);
      expect(infraction.violant_id, 1);
      expect(infraction.agent_id, 1);
      expect(infraction.categorie_id, 1);
    });
  });
}
