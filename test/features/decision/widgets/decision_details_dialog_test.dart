import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
// Removed unnecessary direct controller import; available via decision.dart barrel

void main() {
  group('DecisionDetailsDialog', () {
    testWidgets('opens and shows details with actions', (tester) async {
      final decision = Decision(
        id: 5,
        date: '2024-01-01',
        decisionPrise: 'Alpha',
        infractionId: 7,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => DecisionDetailsDialog(
                      decision: decision,
                      controller: DecisionController(),
                      decisionIndex: 0,
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Date: 2024-01-01'), findsOneWidget);
      expect(find.text('Decision: Alpha'), findsOneWidget);
      expect(find.text('N°Infraction: 7'), findsOneWidget);

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
