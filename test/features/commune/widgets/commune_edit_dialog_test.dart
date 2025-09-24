import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/commune/commune.dart';
import 'package:gmsoft_infractions_mobile/features/commune/widgets/commune_edit_dialog.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
// Removed unnecessary direct controller import; available via commune.dart barrel

class _RecordingCommuneController extends CommuneController {
  int? lastIndex;
  Commune? lastCommune;
  @override
  Future<String> updateCommune(int index, Commune commune) async {
    lastIndex = index;
    lastCommune = commune;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Commune commune,
  required CommuneController controller,
  required int communeIndex,
  Function(int, Commune)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CommuneEditDialog(
                  commune: commune,
                  controller: controller,
                  communeIndex: communeIndex,
                  onCommuneUpdated: onUpdated,
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
  group('CommuneEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final commune = Commune(
        id: 7,
        nom: 'InitN',
        caidat: 'InitC',
        pachalikcircon: 'InitP',
        latitude: 1.2,
        longitude: 3.4,
      );
      final controller = _RecordingCommuneController();

      await _openEditDialog(
        tester,
        commune: commune,
        controller: controller,
        communeIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.widgetWithText(TextFormField, 'InitN'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'InitC'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'InitP'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '1.2'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '3.4'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
    });

    testWidgets('submits update and calls controller and callback',
        (tester) async {
      final commune = Commune(
        id: 9,
        nom: 'Old',
        caidat: 'OldC',
        pachalikcircon: 'OldP',
        latitude: 0.0,
        longitude: 0.0,
      );
      final controller = _RecordingCommuneController();

      int? cbIndex;
      Commune? cbCommune;

      await _openEditDialog(
        tester,
        commune: commune,
        controller: controller,
        communeIndex: 3,
        onUpdated: (i, c) {
          cbIndex = i;
          cbCommune = c;
        },
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'New');
      await tester.enterText(find.byType(TextFormField).at(1), 'NC');
      await tester.enterText(find.byType(TextFormField).at(2), 'NP');
      await tester.enterText(find.byType(TextFormField).at(3), '12.0');
      await tester.enterText(find.byType(TextFormField).at(4), '34.0');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      // Dialog should close
      expect(find.text('Enregistrer'), findsNothing);

      // Controller called
      expect(controller.lastIndex, 3);
      expect(controller.lastCommune, isNotNull);
      expect(controller.lastCommune!.nom, 'New');
      expect(controller.lastCommune!.caidat, 'NC');
      expect(controller.lastCommune!.pachalikcircon, 'NP');
      expect(controller.lastCommune!.latitude, 12.0);
      expect(controller.lastCommune!.longitude, 34.0);

      // Callback executed
      expect(cbIndex, 3);
      expect(cbCommune, isNotNull);
      expect(cbCommune!.nom, 'New');
    });
  });
}
