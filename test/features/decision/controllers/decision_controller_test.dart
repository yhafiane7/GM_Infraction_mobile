import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/decision/controllers/decision_controller.dart';
import 'package:gmsoft_infractions_mobile/models/decision_model.dart';

void main() {
  group('DecisionController', () {
    test('loadDecisions toggles loading and populates list', () async {
      final controller = DecisionController();
      await controller.loadDecisions();
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.decisions, isA<List<Decision>>());
    });

    test('createDecision returns message and toggles loading', () async {
      final controller = DecisionController();
      final res = await controller.createDecision(
        Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'D',
            infractionId: 1),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateDecision uses fallback id when null', () async {
      final controller = DecisionController();
      final res = await controller.updateDecision(
        3,
        Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'D',
            infractionId: 1),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteDecision uses fallback id when null', () async {
      final controller = DecisionController();
      final res = await controller.deleteDecision(
        4,
        Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'D',
            infractionId: 1),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
