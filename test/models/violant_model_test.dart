import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';

void main() {
  group('Violant Model Tests', () {
    test('should create Violant from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Violant',
        'prenom': 'Test',
        'cin': 'VI123456',
      };

      // Act
      final violant = Violant.fromJson(json);

      // Assert
      expect(violant.id, 1);
      expect(violant.nom, 'Violant');
      expect(violant.prenom, 'Test');
      expect(violant.cin, 'VI123456');
    });

    test('should convert Violant to JSON correctly', () {
      // Arrange
      final violant = Violant(
        id: 1,
        nom: 'Violant',
        prenom: 'Test',
        cin: 'VI123456',
      );

      // Act
      final json = violant.toJson();

      // Assert
      expect(json['nom'], 'Violant');
      expect(json['prenom'], 'Test');
      expect(json['cin'], 'VI123456');
      expect(json.containsKey('id'), false); // ID should not be in toJson
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'nom': 'Violant',
        'prenom': 'Test',
        'cin': 'VI123456',
      };

      // Act
      final violant = Violant.fromJson(json);

      // Assert
      expect(violant.id, null);
      expect(violant.nom, 'Violant');
      expect(violant.prenom, 'Test');
      expect(violant.cin, 'VI123456');
    });

    test('should handle API response with timestamps', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Violant',
        'prenom': 'Test',
        'cin': 'VI123456',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      // Act
      final violant = Violant.fromJson(json);

      // Assert
      expect(violant.id, 1);
      expect(violant.nom, 'Violant');
      expect(violant.prenom, 'Test');
      expect(violant.cin, 'VI123456');
      // Timestamps are ignored in the model, which is correct
    });
  });
}
