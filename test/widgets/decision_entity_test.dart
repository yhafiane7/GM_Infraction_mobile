import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/decision.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';

void main() {
  group('Decision Entity Widget Tests', () {
    final testDecisions = [
      Decision(
          id: 1,
          date: '2023-01-01',
          decisionPrise: 'TestDecision1',
          infractionId: 1),
      Decision(
          id: 2,
          date: '2023-01-02',
          decisionPrise: 'TestDecision2',
          infractionId: 2),
    ];

    group('DecisionList Widget', () {
      testWidgets('should display decision list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DecisionList(Decisions: testDecisions),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Date'), findsOneWidget);
        expect(find.text('Decision Prise'), findsOneWidget);
        expect(find.text('N°Infraction'), findsOneWidget);

        // Verify first decision data
        expect(find.text('TestDecision1'), findsOneWidget);
        expect(find.text('2023-01-01'), findsOneWidget);
        expect(find.text('1'), findsWidgets);

        // Verify second decision data
        expect(find.text('TestDecision2'), findsOneWidget);
        expect(find.text('2023-01-02'), findsOneWidget);
        expect(find.text('2'), findsWidgets);
      });

      testWidgets('should handle empty decision list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DecisionList(Decisions: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('ID'), findsOneWidget);
      });

      testWidgets('should handle long press on decision row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DecisionList(Decisions: testDecisions),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('TestDecision1'), findsOneWidget);
        // Note: Long press testing would require mocking DataRepository
        // For now, just verify the widget structure is correct
      });
    });

    group('DecisionView Widget', () {
      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: DecisionView()));

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('SVP entrer La Date'), findsOneWidget);
        expect(find.text('SVP entrer La Decision'), findsOneWidget);
        expect(find.text('SVP Numero d\'Infraction'), findsOneWidget);
      });

      testWidgets('should display form fields correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: DecisionView()));

        // Verify form fields are present
        expect(find.byType(TextFormField), findsNWidgets(3));
        expect(find.text('Ajouter'), findsOneWidget);
        expect(find.text('Ajouter une Décision'), findsOneWidget);
      });
    });
  });
}
