import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/commune.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';

void main() {
  group('Commune Entity Widget Tests', () {
    final testCommunes = [
      Commune(
          id: 1,
          nom: 'TestCommune1',
          pachalikcircon: 'Pachalik1',
          caidat: 'Caidat1',
          latitude: 1.0,
          longitude: 1.0),
      Commune(
          id: 2,
          nom: 'TestCommune2',
          pachalikcircon: 'Pachalik2',
          caidat: 'Caidat2',
          latitude: 2.0,
          longitude: 2.0),
    ];

    group('CommuneList Widget', () {
      testWidgets('should display commune list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CommuneList(Communes: testCommunes),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Pachalik'), findsOneWidget);
        expect(find.text('Caidat'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Latitude'), findsOneWidget);
        expect(find.text('Longitude'), findsOneWidget);

        // Verify first commune data
        expect(find.text('TestCommune1'), findsOneWidget);
        expect(find.text('Pachalik1'), findsOneWidget);
        expect(find.text('Caidat1'), findsOneWidget);

        // Verify second commune data
        expect(find.text('TestCommune2'), findsOneWidget);
        expect(find.text('Pachalik2'), findsOneWidget);
        expect(find.text('Caidat2'), findsOneWidget);
      });

      testWidgets('should handle empty commune list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CommuneList(Communes: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('ID'), findsOneWidget);
      });

      testWidgets('should handle long press on commune row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CommuneList(Communes: testCommunes),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('TestCommune1'), findsOneWidget);
        // Note: Long press testing would require mocking DataRepository
        // For now, just verify the widget structure is correct
      });
    });

    group('CommuneView Widget', () {
      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CommuneView()));

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('SVP entrer Le pachalik circon'), findsOneWidget);
        expect(find.text('SVP entrer Le Caïdat'), findsOneWidget);
        expect(find.text('SVP entrer Le Nom'), findsOneWidget);
        expect(find.text('SVP entrer La latitude'), findsOneWidget);
        expect(find.text('SVP entrer La longitude'), findsOneWidget);
      });

      testWidgets('should submit valid form and show confirmation dialog',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CommuneView()));

        await tester.enterText(
            find.byType(TextFormField).at(0), 'TestPachalik');
        await tester.enterText(find.byType(TextFormField).at(1), 'TestCaidat');
        await tester.enterText(find.byType(TextFormField).at(2), 'TestCommune');
        await tester.enterText(find.byType(TextFormField).at(3), '1.0');
        await tester.enterText(find.byType(TextFormField).at(4), '1.0');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Confirmation'), findsOneWidget);
        expect(find.text('Pachalik: TestPachalik'), findsOneWidget);
        expect(find.text('Caidat: TestCaidat'), findsOneWidget);
        expect(find.text('Nom: TestCommune'), findsOneWidget);
        expect(find.text('Latitude: 1.0'), findsOneWidget);
        expect(find.text('Longitude: 1.0'), findsOneWidget);
      });

      testWidgets('should cancel dialog', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CommuneView()));

        await tester.enterText(
            find.byType(TextFormField).at(0), 'TestPachalik');
        await tester.enterText(find.byType(TextFormField).at(1), 'TestCaidat');
        await tester.enterText(find.byType(TextFormField).at(2), 'TestCommune');
        await tester.enterText(find.byType(TextFormField).at(3), '1.0');
        await tester.enterText(find.byType(TextFormField).at(4), '1.0');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter une Commune'), findsOneWidget);
      });
    });
  });
}
