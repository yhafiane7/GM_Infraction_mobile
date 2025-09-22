import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/categorie/categorie.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/features/categorie/controllers/categorie_controller.dart';

class _RecordingCategorieController extends CategorieController {
  int? lastIndex;
  Categorie? lastCategorie;
  @override
  Future<String> updateCategorie(int index, Categorie categorie) async {
    lastIndex = index;
    lastCategorie = categorie;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Categorie categorie,
  required CategorieController controller,
  required int categoryIndex,
  Function(int, Categorie)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CategorieEditDialog(
                  categorie: categorie,
                  controller: controller,
                  categoryIndex: categoryIndex,
                  onCategoryUpdated: onUpdated,
                ),
              );
            },
            child: const Text('OpenEdit'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('OpenEdit'));
  await tester.pumpAndSettle();
}

void main() {
  group('CategorieEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final categorie = Categorie(id: 10, nom: 'Init', degre: 4);
      final controller = _RecordingCategorieController();

      await _openEditDialog(
        tester,
        categorie: categorie,
        controller: controller,
        categoryIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Init'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
      expect(find.text('Annuler'), findsOneWidget);
    });

    testWidgets('calls update with edited values and pops on success',
        (tester) async {
      final initial = Categorie(id: 11, nom: 'Old', degre: 2);
      final controller = _RecordingCategorieController();
      int? callbackIndex;
      Categorie? callbackCategorie;

      await _openEditDialog(
        tester,
        categorie: initial,
        controller: controller,
        categoryIndex: 1,
        onUpdated: (idx, c) {
          callbackIndex = idx;
          callbackCategorie = c;
        },
      );

      await tester.enterText(find.byType(TextFormField).first, 'NewName');
      await tester.enterText(find.byType(TextFormField).last, '7');
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      // Dialog should close after successful save
      expect(find.text('Enregistrer'), findsNothing);

      // Controller received correct values
      expect(controller.lastIndex, 1);
      expect(controller.lastCategorie?.id, 11);
      expect(controller.lastCategorie?.nom, 'NewName');
      expect(controller.lastCategorie?.degre, 7);

      // onCategoryUpdated called with same values
      expect(callbackIndex, 1);
      expect(callbackCategorie?.id, 11);
      expect(callbackCategorie?.nom, 'NewName');
      expect(callbackCategorie?.degre, 7);
    });

    testWidgets('keeps original degree when edited degree is invalid',
        (tester) async {
      final initial = Categorie(id: 12, nom: 'Name', degre: 3);
      final controller = _RecordingCategorieController();

      await _openEditDialog(
        tester,
        categorie: initial,
        controller: controller,
        categoryIndex: 2,
      );

      await tester.enterText(find.byType(TextFormField).first, 'Changed');
      await tester.enterText(find.byType(TextFormField).last, 'abc');
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(controller.lastIndex, 2);
      expect(controller.lastCategorie?.id, 12);
      expect(controller.lastCategorie?.nom, 'Changed');
      // Fallback to original degree when parsing fails
      expect(controller.lastCategorie?.degre, 3);
    });

    testWidgets('Annuler closes without calling update', (tester) async {
      final initial = Categorie(id: 13, nom: 'Cancel', degre: 5);
      final controller = _RecordingCategorieController();

      await _openEditDialog(
        tester,
        categorie: initial,
        controller: controller,
        categoryIndex: 3,
      );

      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      // Dialog closed
      expect(find.text('Enregistrer'), findsNothing);
      // No update call
      expect(controller.lastIndex, isNull);
      expect(controller.lastCategorie, isNull);
    });
  });
}
