import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
// Removed unnecessary direct controller import; available via decision.dart barrel

void main() {
  group('DecisionListWidget', () {
    final testDecisions = [
      Decision(id: 1, date: '2024-01-01', decisionPrise: 'D1', infractionId: 1),
      Decision(id: 2, date: '2024-01-02', decisionPrise: 'D2', infractionId: 2),
    ];

    testWidgets('displays table headers and rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DecisionListWidget(
              decisions: testDecisions,
              controller: DecisionController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Decision Prise'), findsOneWidget);
      expect(find.text('N°Infraction'), findsOneWidget);

      expect(find.text('D1'), findsOneWidget);
      expect(find.text('D2'), findsOneWidget);
    });

    testWidgets('handles empty list without controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DecisionListWidget(decisions: []),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
    });

    testWidgets('long press opens details dialog when controller provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DecisionListWidget(
              decisions: testDecisions,
              controller: DecisionController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('D1'));
      await tester.pumpAndSettle();

      expect(find.text('Date: 2024-01-01'), findsOneWidget);
      expect(find.text('Decision: D1'), findsOneWidget);
      expect(find.text('N°Infraction: 1'), findsOneWidget);
    });
  });
}
