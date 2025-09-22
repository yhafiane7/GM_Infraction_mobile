import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';

void main() {
  group('Categorie Model Tests', () {
    test('should create Categorie from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'TestCategorie',
        'degre': 1,
      };

      // Act
      final categorie = Categorie.fromJson(json);

      // Assert
      expect(categorie.id, 1);
      expect(categorie.nom, 'TestCategorie');
      expect(categorie.degre, 1);
    });

    test('should convert Categorie to JSON correctly', () {
      // Arrange
      final categorie = Categorie(
        id: 1,
        nom: 'TestCategorie',
        degre: 1,
      );

      // Act
      final json = categorie.toJson();

      // Assert
      expect(json['nom'], 'TestCategorie');
      expect(json['degre'], 1);
      expect(json.containsKey('id'), false); // ID should not be in toJson
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'nom': 'TestCategorie',
        'degre': 1,
      };

      // Act
      final categorie = Categorie.fromJson(json);

      // Assert
      expect(categorie.id, null);
      expect(categorie.nom, 'TestCategorie');
      expect(categorie.degre, 1);
    });

    test('should handle API response with timestamps', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'TestCategorie',
        'degre': 1,
        'created_at': '2025-01-01T00:00:00Z',
        'updated_at': '2025-01-01T00:00:00Z',
      };

      // Act
      final categorie = Categorie.fromJson(json);

      // Assert
      expect(categorie.id, 1);
      expect(categorie.nom, 'TestCategorie');
      expect(categorie.degre, 1);
      // Timestamps are ignored in the model, which is correct
    });
  });
}
