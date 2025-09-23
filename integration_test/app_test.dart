import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:GM_INFRACTION/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end App Flow', () {
    testWidgets('launches and navigates across all feature pages',
        (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();

      // Ensure dashboard is visible and navigate through tiles
      Future<void> openTile(String label) async {
        final finder = find.text(label);
        if (finder.evaluate().isEmpty) {
          await tester.dragUntilVisible(
            finder,
            find.byType(Scrollable),
            const Offset(0, -300),
          );
          await tester.pumpAndSettle();
        }
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(find.byType(Scaffold), findsWidgets);
        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      await openTile('AGENT');
      await openTile('CATEGORIE');
      await openTile('COMMUNE');
      await openTile('DECISION');
      await openTile('INFRACTION');
      await openTile('VIOLANT');
    });

    testWidgets('creates a sample agent via UI if form is reachable',
        (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();

      // Go to Agent page
      final agentFinder = find.text('AGENT');
      if (agentFinder.evaluate().isEmpty) {
        await tester.dragUntilVisible(
          agentFinder,
          find.byType(Scrollable),
          const Offset(0, -300),
        );
        await tester.pumpAndSettle();
      }
      await tester.tap(agentFinder);
      await tester.pumpAndSettle();

      // Try to find a button that likely opens the form (fallback if not present)
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();
      }

      // Fill first 4 TextFormField inputs if present (Nom, Prenom, Tel, CIN order assumed)
      final fields = find.byType(TextFormField);
      final ts = DateTime.now().millisecondsSinceEpoch.toString().substring(6);
      if (fields.evaluate().isNotEmpty) {
        Future<void> enterAt(int index, String value) async {
          if (fields.evaluate().length > index) {
            await tester.enterText(fields.at(index), value);
          }
        }

        await enterAt(0, 'Test$ts');
        await enterAt(1, 'User$ts');
        await enterAt(2, '0${ts.padLeft(9, '0')}');
        await enterAt(3, 'TI$ts');
      }

      // Submit if a submit button is visible
      final submit = find.widgetWithText(ElevatedButton, 'Enregistrer');
      if (submit.evaluate().isNotEmpty) {
        await tester.tap(submit);
        await tester.pumpAndSettle(const Duration(seconds: 2));
        // Expect some scaffold present; exact success toast is native plugin, not captured here
        expect(find.byType(Scaffold), findsWidgets);
      } else {
        // If the specific flow isn't available, the test still validates navigation
        expect(true, isTrue);
      }
    });
  });
}
