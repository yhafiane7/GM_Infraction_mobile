import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/infraction.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';
// Removed unnecessary direct controller import; available via infraction.dart barrel

class _RecordingInfractionController extends InfractionController {
  int? lastIndex;
  Infraction? lastInfraction;
  @override
  Future<String> updateInfraction(int index, Infraction infraction) async {
    lastIndex = index;
    lastInfraction = infraction;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Infraction infraction,
  required InfractionController controller,
  required int infractionIndex,
  Function(int, Infraction)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => InfractionEditDialog(
                  infraction: infraction,
                  controller: controller,
                  infractionIndex: infractionIndex,
                  onInfractionUpdated: onUpdated,
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
  group('InfractionEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final infraction = Infraction(
        id: 10,
        nom: 'InitN',
        date: '2024-01-01',
        adresse: 'Addr',
        commune_id: 1,
        violant_id: 2,
        agent_id: 3,
        categorie_id: 4,
        latitude: 1.2,
        longitude: 3.4,
      );
      final controller = _RecordingInfractionController();

      await _openEditDialog(
        tester,
        infraction: infraction,
        controller: controller,
        infractionIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(9));
      expect(find.widgetWithText(TextFormField, 'InitN'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '2024-01-01'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Addr'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '1'), findsWidgets);
      expect(find.widgetWithText(TextFormField, '2'), findsWidgets);
      expect(find.widgetWithText(TextFormField, '3'), findsWidgets);
      expect(find.widgetWithText(TextFormField, '4'), findsWidgets);
      expect(find.widgetWithText(TextFormField, '1.2'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '3.4'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
    });

    testWidgets('submits update and calls controller and callback',
        (tester) async {
      final infraction = Infraction(
        id: 9,
        nom: 'Old',
        date: '2024-01-01',
        adresse: 'Addr',
        commune_id: 1,
        violant_id: 2,
        agent_id: 3,
        categorie_id: 4,
        latitude: 0.0,
        longitude: 0.0,
      );
      final controller = _RecordingInfractionController();

      int? cbIndex;
      Infraction? cbInfraction;

      await _openEditDialog(
        tester,
        infraction: infraction,
        controller: controller,
        infractionIndex: 3,
        onUpdated: (i, inf) {
          cbIndex = i;
          cbInfraction = inf;
        },
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'New');
      // Do not edit the readOnly date field (index 1)
      await tester.enterText(find.byType(TextFormField).at(2), 'NewAddr');
      await tester.enterText(find.byType(TextFormField).at(3), '11');
      await tester.enterText(find.byType(TextFormField).at(4), '22');
      await tester.enterText(find.byType(TextFormField).at(5), '33');
      await tester.enterText(find.byType(TextFormField).at(6), '44');
      await tester.enterText(find.byType(TextFormField).at(7), '12.0');
      await tester.enterText(find.byType(TextFormField).at(8), '34.0');

      // Scroll within dialog to ensure the button is visible
      final dialogRoot = find.byType(InfractionEditDialog);
      final dialogScrollable = find
          .descendant(of: dialogRoot, matching: find.byType(Scrollable))
          .first;
      await tester.scrollUntilVisible(find.text('Enregistrer'), 300,
          scrollable: dialogScrollable);

      final saveButton = find.descendant(
        of: dialogRoot,
        matching: find
            .byWidgetPredicate((w) => w is FilledButton && w.onPressed != null),
      );
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer'), findsNothing);

      expect(controller.lastIndex, 3);
      expect(controller.lastInfraction, isNotNull);
      expect(controller.lastInfraction!.nom, 'New');
      // Date remains unchanged
      expect(controller.lastInfraction!.date, '2024-01-01');
      expect(controller.lastInfraction!.adresse, 'NewAddr');
      expect(controller.lastInfraction!.commune_id, 11);
      expect(controller.lastInfraction!.violant_id, 22);
      expect(controller.lastInfraction!.agent_id, 33);
      expect(controller.lastInfraction!.categorie_id, 44);
      expect(controller.lastInfraction!.latitude, 12.0);
      expect(controller.lastInfraction!.longitude, 34.0);

      expect(cbIndex, 3);
      expect(cbInfraction, isNotNull);
      expect(cbInfraction!.nom, 'New');
      expect(cbInfraction!.date, '2024-01-01');
    });
  });
}
