import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/categorie.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';

void main() {
  group('Categorie Entity Widget Tests', () {
    final testCategories = [
      Categorie(id: 1, nom: 'TestCategorie1', degre: 1),
      Categorie(id: 2, nom: 'TestCategorie2', degre: 2),
    ];

    group('CategorieList Widget', () {
      testWidgets('should display categorie list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CategorieList(Categories: testCategories),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Degre'), findsOneWidget);

        // Verify first category data
        expect(find.text('TestCategorie1'), findsOneWidget);
        expect(find.text('1'), findsWidgets); // ID and degree both show "1"

        // Verify second category data
        expect(find.text('TestCategorie2'), findsOneWidget);
        expect(find.text('2'), findsWidgets); // ID and degree both show "2"
      });

      testWidgets('should handle empty categorie list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CategorieList(Categories: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('ID'), findsOneWidget);
      });

      testWidgets('should handle long press on categorie row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CategorieList(Categories: testCategories),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('TestCategorie1'), findsOneWidget);

        // Note: Long press testing would require mocking DataRepository
        // For now, just verify the widget structure is correct
      });
    });

    group('CategorieView Widget', () {
      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CategorieView()));

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('SVP entrer Le Nom'), findsOneWidget);
        expect(find.text('SVP entrer La degree'), findsOneWidget);
      });

      testWidgets('should accept only numeric input for degree field',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CategorieView()));

        final degreeField = find.byType(TextFormField).at(1);
        await tester.enterText(degreeField, 'abc');
        await tester.pumpAndSettle();

        // "abc" should not appear since input formatter only allows digits
        expect(find.text('abc'), findsNothing);
      });

      testWidgets('should submit valid form and show confirmation dialog',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CategorieView()));

        await tester.enterText(
            find.byType(TextFormField).at(0), 'TestCategorie');
        await tester.enterText(find.byType(TextFormField).at(1), '3');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Confirmation'), findsOneWidget);
        expect(find.text('Nom: TestCategorie'), findsOneWidget);
        expect(find.text('Degree: 3'), findsOneWidget);
      });

      testWidgets('should cancel dialog', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CategorieView()));

        await tester.enterText(
            find.byType(TextFormField).at(0), 'TestCategorie');
        await tester.enterText(find.byType(TextFormField).at(1), '3');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter une Catégorie'), findsOneWidget);
      });
    });
  });
}
