import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';

void main() {
  group('Decision Model Tests', () {
    test('should create Decision from JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'date': '2024-01-01',
        'decisionprise': 'Test Decision',
        'infraction_id': '1',
      };

      // Act
      final decision = Decision.fromJson(json);

      // Assert
      expect(decision.id, 1);
      expect(decision.date, '2024-01-01');
      expect(decision.decisionPrise, 'Test Decision');
      expect(decision.infractionId, 1);
    });

    test('should convert Decision to JSON correctly', () {
      // Arrange
      final decision = Decision(
        id: 1,
        date: '2024-01-01',
        decisionPrise: 'Test Decision',
        infractionId: 1,
      );

      // Act
      final json = decision.toJson();

      // Assert
      expect(json['id'], 1);
      expect(json['date'], '2024-01-01');
      expect(json['decisionprise'], 'Test Decision');
      expect(json['infraction_id'], 1);
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'date': '2024-01-01',
        'decisionprise': 'Test Decision',
        'infraction_id': '1',
      };

      // Act
      final decision = Decision.fromJson(json);

      // Assert
      expect(decision.id, null);
      expect(decision.date, '2024-01-01');
      expect(decision.decisionPrise, 'Test Decision');
      expect(decision.infractionId, 1);
    });

    test('should handle numeric infraction_id in JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'date': '2024-01-01',
        'decisionprise': 'Test Decision',
        'infraction_id': 1,
      };

      // Act
      final decision = Decision.fromJson(json);

      // Assert
      expect(decision.infractionId, 1);
    });

    test('should handle API response with timestamps', () {
      // Arrange
      final json = {
        'id': 1,
        'date': '2024-01-01',
        'decisionprise': 'Test Decision',
        'infraction_id': '1',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      // Act
      final decision = Decision.fromJson(json);

      // Assert
      expect(decision.id, 1);
      expect(decision.date, '2024-01-01');
      expect(decision.decisionPrise, 'Test Decision');
      expect(decision.infractionId, 1);
      // Timestamps are ignored in the model, which is correct
    });
  });
}
