import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/features/decision/controllers/decision_controller.dart';

class _RecordingDecisionController extends DecisionController {
  int? lastIndex;
  Decision? lastDecision;
  @override
  Future<String> updateDecision(int index, Decision decision) async {
    lastIndex = index;
    lastDecision = decision;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Decision decision,
  required DecisionController controller,
  required int decisionIndex,
  Function(int, Decision)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => DecisionEditDialog(
                  decision: decision,
                  controller: controller,
                  decisionIndex: decisionIndex,
                  onDecisionUpdated: onUpdated,
                ),
              );
            },
            child: const Text('OpenEdit'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('OpenEdit'));
  await tester.pumpAndSettle();
}

void main() {
  group('DecisionEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final decision = Decision(
        id: 10,
        date: '2024-01-01',
        decisionPrise: 'Alpha',
        infractionId: 7,
      );
      final controller = _RecordingDecisionController();

      await _openEditDialog(
        tester,
        decision: decision,
        controller: controller,
        decisionIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.widgetWithText(TextFormField, '2024-01-01'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Alpha'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '7'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
    });

    testWidgets('submits update and calls controller and callback',
        (tester) async {
      final decision = Decision(
        id: 9,
        date: '2024-01-01',
        decisionPrise: 'Old',
        infractionId: 1,
      );
      final controller = _RecordingDecisionController();

      int? cbIndex;
      Decision? cbDecision;

      await _openEditDialog(
        tester,
        decision: decision,
        controller: controller,
        decisionIndex: 3,
        onUpdated: (i, d) {
          cbIndex = i;
          cbDecision = d;
        },
      );

      // Do NOT edit the date (readOnly, set via date picker). Only update other fields.
      await tester.enterText(find.byType(TextFormField).at(1), 'New');
      await tester.enterText(find.byType(TextFormField).at(2), '42');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer'), findsNothing);

      expect(controller.lastIndex, 3);
      expect(controller.lastDecision, isNotNull);
      // Date remains unchanged
      expect(controller.lastDecision!.date, '2024-01-01');
      expect(controller.lastDecision!.decisionPrise, 'New');
      expect(controller.lastDecision!.infractionId, 42);

      expect(cbIndex, 3);
      expect(cbDecision, isNotNull);
      expect(cbDecision!.decisionPrise, 'New');
      expect(cbDecision!.date, '2024-01-01');
    });
  });
}
