import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/categorie/categorie.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/features/categorie/controllers/categorie_controller.dart';

void main() {
  group('CategorieListWidget', () {
    final testCategories = [
      Categorie(id: 1, nom: 'Test Categorie 1', degre: 1),
      Categorie(id: 2, nom: 'Test Categorie 2', degre: 2),
      Categorie(id: 3, nom: 'Test Categorie 3', degre: 3),
    ];

    testWidgets('displays list with correct data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: testCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Degre'), findsOneWidget);
      expect(find.text('Test Categorie 1'), findsOneWidget);
      expect(find.text('Test Categorie 2'), findsOneWidget);
      expect(find.text('Test Categorie 3'), findsOneWidget);
    });

    testWidgets('handles empty list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(categories: []),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
    });

    testWidgets('long press shows details dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: testCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Test Categorie 1'));
      await tester.pumpAndSettle();

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });

    testWidgets('DataTable structure is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: testCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );

      final dataTable = tester.widget<DataTable>(find.byType(DataTable));
      expect(dataTable.columns.length, 4);
      expect(dataTable.rows.length, testCategories.length);
    });

    testWidgets('responsive and scrollable', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: testCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );
      expect(find.byType(DataTable), findsOneWidget);
      await tester.binding.setSurfaceSize(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: testCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('handles invalid data gracefully', (WidgetTester tester) async {
      final invalidCategories = [
        Categorie(id: null, nom: '', degre: -1),
        Categorie(id: 1, nom: 'Valid', degre: 1),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: invalidCategories,
              controller: CategorieController(),
            ),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('Valid'), findsOneWidget);
    });
  });
}
