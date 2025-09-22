import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/categorie/categorie.dart';

void main() {
  group('CategorieViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CategorieViewWidget(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter une Catégorie'), findsOneWidget);
    });
  });
}
