import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart';
import 'package:GM_INFRACTION/features/decision/controllers/decision_controller.dart';
import '../../../test_helpers/date_picker_helper.dart';

void main() {
  group('DecisionFormWidget', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DecisionFormWidget(controller: DecisionController()),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DecisionFormWidget(controller: DecisionController()),
          ),
        ),
      );

      final formRoot = find.byType(DecisionFormWidget);
      final scrollable = find
          .descendant(of: formRoot, matching: find.byType(Scrollable))
          .first;
      await tester.scrollUntilVisible(find.text('Ajouter'), 200,
          scrollable: scrollable);

      final enabledButton = find.descendant(
        of: formRoot,
        matching: find.byWidgetPredicate(
          (w) => w is ElevatedButton && w.onPressed != null,
        ),
      );
      await tester.tap(enabledButton);
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer La Date'), findsOneWidget);
      expect(find.text('SVP entrer La Decision'), findsOneWidget);
      expect(find.text("SVP Numero d'Infraction"), findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DecisionFormWidget(controller: DecisionController()),
          ),
        ),
      );

      await pickDateViaPicker(tester, find.byType(TextFormField).at(0));
      await tester.enterText(find.byType(TextFormField).at(1), 'My Decision');
      await tester.enterText(find.byType(TextFormField).at(2), '42');

      final formRoot = find.byType(DecisionFormWidget);
      final scrollable = find
          .descendant(of: formRoot, matching: find.byType(Scrollable))
          .first;
      await tester.scrollUntilVisible(find.text('Ajouter'), 200,
          scrollable: scrollable);

      final enabledButton = find.descendant(
        of: formRoot,
        matching: find.byWidgetPredicate(
          (w) => w is ElevatedButton && w.onPressed != null,
        ),
      );
      await tester.tap(enabledButton);
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Decision Details:'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Text && w.data != null && w.data!.startsWith('Date: '),
        ),
        findsOneWidget,
      );
      expect(find.text('Decision Prise: My Decision'), findsOneWidget);
      expect(find.text('N°Infraction: 42'), findsOneWidget);
    });
  });
}
