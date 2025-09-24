import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';

void main() {
  group('Agent Model Tests', () {
    test('should create Agent from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Doe',
        'prenom': 'John',
        'tel': '1234567890',
        'cin': 'AB123456',
      };

      // Act
      final agent = Agent.fromJson(json);

      // Assert
      expect(agent.id, 1);
      expect(agent.nom, 'Doe');
      expect(agent.prenom, 'John');
      expect(agent.tel, '1234567890');
      expect(agent.cin, 'AB123456');
    });

    test('should convert Agent to JSON correctly', () {
      // Arrange
      final agent = Agent(
        id: 1,
        nom: 'Doe',
        prenom: 'John',
        tel: '1234567890',
        cin: 'AB123456',
      );

      // Act
      final json = agent.toJson();

      // Assert
      expect(json['nom'], 'Doe');
      expect(json['prenom'], 'John');
      expect(json['tel'], '1234567890');
      expect(json['cin'], 'AB123456');
      expect(json.containsKey('id'), false); // ID should not be in toJson
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'nom': 'Doe',
        'prenom': 'John',
        'tel': '1234567890',
        'cin': 'AB123456',
      };

      // Act
      final agent = Agent.fromJson(json);

      // Assert
      expect(agent.id, null);
      expect(agent.nom, 'Doe');
      expect(agent.prenom, 'John');
      expect(agent.tel, '1234567890');
      expect(agent.cin, 'AB123456');
    });

    test('should handle API response with timestamps', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Doe',
        'prenom': 'John',
        'tel': '1234567890',
        'cin': 'AB123456',
        'created_at': '2025-01-01T00:00:00Z',
        'updated_at': '2025-01-01T00:00:00Z',
      };

      // Act
      final agent = Agent.fromJson(json);

      // Assert
      expect(agent.id, 1);
      expect(agent.nom, 'Doe');
      // Timestamps are ignored in the model, which is correct
    });
  });
}
