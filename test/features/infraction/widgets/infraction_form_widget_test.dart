import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/infraction.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
// Removed unnecessary direct controller import; available via infraction.dart barrel
import '../../../test_helpers/date_picker_helper.dart';

void main() {
  group('InfractionFormWidget', () {
    final communes = [
      Commune(
          id: 1,
          nom: 'C1',
          caidat: 'Ca',
          pachalikcircon: 'Pa',
          latitude: 1,
          longitude: 2)
    ];
    final violants = [Violant(id: 2, nom: 'Vn', prenom: 'Vp', cin: 'VCIN')];
    final agents = [
      Agent(id: 3, nom: 'An', prenom: 'Ap', tel: '0123456789', cin: 'ACIN')
    ];
    final categories = [Categorie(id: 4, nom: 'Cat', degre: 1)];

    Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

    Finder _dropdownFinder() =>
        find.byWidgetPredicate((w) => w is DropdownButtonFormField);

    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(_wrap(InfractionFormWidget(
        communes: communes,
        violants: violants,
        agents: agents,
        categories: categories,
        controller: InfractionController(),
      )));

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
      expect(_dropdownFinder(), findsNWidgets(4));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required fields', (tester) async {
      await tester.pumpWidget(_wrap(InfractionFormWidget(
        communes: communes,
        violants: violants,
        agents: agents,
        categories: categories,
        controller: InfractionController(),
      )));

      final formRoot = find.byType(InfractionFormWidget);
      final scrollable = find
          .descendant(of: formRoot, matching: find.byType(Scrollable))
          .first;
      await tester.scrollUntilVisible(find.text('Ajouter'), 300,
          scrollable: scrollable);

      final enabledButton = find.descendant(
        of: formRoot,
        matching: find.byWidgetPredicate(
          (w) => w is ElevatedButton && w.onPressed != null,
        ),
      );
      await tester.tap(enabledButton);
      await tester.pumpAndSettle();

      expect(find.text('SVP Entrer Le Nom '), findsOneWidget);
      expect(find.text('SVP entrer La Date'), findsOneWidget);
      expect(find.text('SVP entrer une adresse'), findsOneWidget);
      expect(find.text('SVP entrer La latitude'), findsOneWidget);
      expect(find.text('SVP entrer La longitude'), findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(_wrap(InfractionFormWidget(
        communes: communes,
        violants: violants,
        agents: agents,
        categories: categories,
        controller: InfractionController(),
      )));

      await tester.enterText(find.byType(TextFormField).at(0), 'Infraction A');
      await pickDateViaPicker(tester, find.byType(TextFormField).at(1));
      await tester.enterText(find.byType(TextFormField).at(2), 'Rue 123');

      await tester.tap(find.text('Commune').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('C1').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Violent').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Vn Vp').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Agent').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('An Ap').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Categorie').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cat').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(3), '12.3');
      await tester.enterText(find.byType(TextFormField).at(4), '45.6');

      final formRoot = find.byType(InfractionFormWidget);
      final scrollable = find
          .descendant(of: formRoot, matching: find.byType(Scrollable))
          .first;
      await tester.scrollUntilVisible(find.text('Ajouter'), 300,
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
      expect(find.text('Infraction Details:'), findsOneWidget);
      expect(find.text('Nom: Infraction A'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Text && w.data != null && w.data!.startsWith('Date: '),
        ),
        findsOneWidget,
      );
      expect(find.text('Adresse: Rue 123'), findsOneWidget);
      expect(find.text('Commune: 1'), findsOneWidget);
      expect(find.text('Violant: 2'), findsOneWidget);
      expect(find.text('Agent: 3'), findsOneWidget);
      expect(find.text('Catégorie: 4'), findsOneWidget);
      expect(find.text('Latitude: 12.3'), findsOneWidget);
      expect(find.text('Longitude: 45.6'), findsOneWidget);
    });
  });
}
