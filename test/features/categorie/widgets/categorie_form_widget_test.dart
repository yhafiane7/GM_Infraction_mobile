import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/categorie/categorie.dart';
import 'package:GM_INFRACTION/features/categorie/controllers/categorie_controller.dart';

void main() {
  group('CategorieFormWidget', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieFormWidget(controller: CategorieController()),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieFormWidget(controller: CategorieController()),
          ),
        ),
      );

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer Le Nom'), findsOneWidget);
      expect(find.text('SVP entrer La degré'), findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieFormWidget(controller: CategorieController()),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'New Categorie');
      await tester.enterText(find.byType(TextFormField).at(1), '3');
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Nom: New Categorie'), findsOneWidget);
      expect(find.text('Degré: 3'), findsOneWidget);
    });

    testWidgets('degree field integer validation via formatter',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorieFormWidget(controller: CategorieController()),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(1), 'abc');
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      // Non-numeric ignored; triggers required degree error
      expect(find.text('SVP entrer La degré'), findsOneWidget);
    });
  });
}
