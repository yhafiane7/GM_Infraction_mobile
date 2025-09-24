import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/violant/violant.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
// Removed unnecessary direct controller import; available via violant.dart barrel

class _RecordingViolantController extends ViolantController {
  int? lastIndex;
  Violant? lastViolant;
  @override
  Future<String> updateViolant(int index, Violant violant) async {
    lastIndex = index;
    lastViolant = violant;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Violant violant,
  required ViolantController controller,
  required int violantIndex,
  Function(int, Violant)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ViolantEditDialog(
                  violant: violant,
                  controller: controller,
                  violantIndex: violantIndex,
                  onViolantUpdated: onUpdated,
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
  group('ViolantEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final violant = Violant(
        id: 10,
        nom: 'InitN',
        prenom: 'InitP',
        cin: 'VI123456',
      );
      final controller = _RecordingViolantController();

      await _openEditDialog(
        tester,
        violant: violant,
        controller: controller,
        violantIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.widgetWithText(TextFormField, 'InitN'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'InitP'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'VI123456'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
    });

    testWidgets('submits update and calls controller and callback',
        (tester) async {
      final violant = Violant(
        id: 9,
        nom: 'Old',
        prenom: 'OP',
        cin: 'ZZ111111',
      );
      final controller = _RecordingViolantController();

      int? cbIndex;
      Violant? cbViolant;

      await _openEditDialog(
        tester,
        violant: violant,
        controller: controller,
        violantIndex: 3,
        onUpdated: (i, v) {
          cbIndex = i;
          cbViolant = v;
        },
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'New');
      await tester.enterText(find.byType(TextFormField).at(1), 'NP');
      await tester.enterText(find.byType(TextFormField).at(2), 'CD789012');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer'), findsNothing);

      expect(controller.lastIndex, 3);
      expect(controller.lastViolant, isNotNull);
      expect(controller.lastViolant!.nom, 'New');
      expect(controller.lastViolant!.prenom, 'NP');
      expect(controller.lastViolant!.cin, 'CD789012');

      expect(cbIndex, 3);
      expect(cbViolant, isNotNull);
      expect(cbViolant!.nom, 'New');
    });
  });
}
