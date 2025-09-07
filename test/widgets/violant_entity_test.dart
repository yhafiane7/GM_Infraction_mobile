import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/violant.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';

void main() {
  group('Violant Entity Widget Tests', () {
    final testViolants = [
      Violant(id: 1, nom: 'Violant1', prenom: 'Test1', cin: 'VI123456'),
      Violant(id: 2, nom: 'Violant2', prenom: 'Test2', cin: 'VI789012'),
    ];

    group('ViolantList Widget', () {
      testWidgets('should display violant list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ViolantList(Violants: testViolants),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Prénom'), findsOneWidget);
        expect(find.text('CIN'), findsOneWidget);

        // Verify violant data
        expect(find.text('Violant1'), findsOneWidget);
        expect(find.text('Test1'), findsOneWidget);
        expect(find.text('VI123456'), findsOneWidget);
      });

      testWidgets('should handle empty violant list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ViolantList(Violants: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
      });

      testWidgets('should handle long press on violant row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ViolantList(Violants: testViolants),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('Violant1'), findsOneWidget);

        // Note: Long press testing would require mocking DataRepository
      });
    });

    group('ViolantView Widget', () {
      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: ViolantView()));

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('SVP entrer Le Nom'), findsOneWidget);
        expect(find.text('SVP entrer Le Prénom'), findsOneWidget);
        expect(find.text('SVP entrer Le CIN'), findsOneWidget);
      });

      testWidgets('should submit valid form and show confirmation dialog',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: ViolantView()));

        await tester.enterText(find.byType(TextFormField).at(0), 'TestViolant');
        await tester.enterText(find.byType(TextFormField).at(1), 'TestPrenom');
        await tester.enterText(find.byType(TextFormField).at(2), 'VI123456');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Confirmation'), findsOneWidget);
        expect(find.text('Nom: TestViolant'), findsOneWidget);
        expect(find.text('Prenom: TestPrenom'), findsOneWidget);
        expect(find.text('CIN: VI123456'), findsOneWidget);
      });

      testWidgets('should cancel dialog', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: ViolantView()));

        await tester.enterText(find.byType(TextFormField).at(0), 'TestViolant');
        await tester.enterText(find.byType(TextFormField).at(1), 'TestPrenom');
        await tester.enterText(find.byType(TextFormField).at(2), 'VI123456');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter un Violant'), findsOneWidget);
      });
    });
  });
}
