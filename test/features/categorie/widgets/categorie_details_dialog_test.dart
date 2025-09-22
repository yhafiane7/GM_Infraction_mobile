import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/categorie/categorie.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/features/categorie/controllers/categorie_controller.dart';

void main() {
  group('CategorieDetailsDialog via long-press', () {
    testWidgets('opens from CategorieListWidget and shows actions',
        (tester) async {
      final categories = [Categorie(id: 1, nom: 'Name', degre: 2)];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieListWidget(
              categories: categories,
              controller: CategorieController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Name'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: Name'), findsOneWidget);
      expect(find.text('Degré: 2'), findsOneWidget);
      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
