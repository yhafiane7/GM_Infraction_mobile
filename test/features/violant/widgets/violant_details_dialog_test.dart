import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/violant/violant.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/features/violant/controllers/violant_controller.dart';

void main() {
  group('ViolantDetailsDialog', () {
    testWidgets('opens and shows details with actions', (tester) async {
      final violant = Violant(
        id: 5,
        nom: 'Alpha',
        prenom: 'Beta',
        cin: 'VI123456',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ViolantDetailsDialog(
                      violant: violant,
                      controller: ViolantController(),
                      violantIndex: 0,
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: Alpha'), findsOneWidget);
      expect(find.text('Prénom: Beta'), findsOneWidget);
      expect(find.text('CIN: VI123456'), findsOneWidget);

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
