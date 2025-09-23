import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Decision Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildDecisionList returns a List<Decision>', () async {
      final items = await UiService.buildDecisionList();
      expect(items, isA<List<Decision>>());
    });

    test('performDecisionCreate returns String message', () async {
      final item = Decision(
        date: DateTime.now().toIso8601String(),
        decisionPrise: 'D',
        infractionId: 1,
      );
      final result = await UiService.performDecisionCreate(item);
      expect(result, isA<String>());
    });

    test('performDecisionUpdate returns String message', () async {
      final item = Decision(
        id: 1,
        date: DateTime.now().toIso8601String(),
        decisionPrise: 'D',
        infractionId: 1,
      );
      final result = await UiService.performDecisionUpdate(1, item);
      expect(result, isA<String>());
    });

    test('performDecisionDelete returns String message', () async {
      final item = Decision(
        id: 1,
        date: DateTime.now().toIso8601String(),
        decisionPrise: 'D',
        infractionId: 1,
      );
      final result = await UiService.performDecisionDelete(1, item);
      expect(result, isA<String>());
    });
  });
}


