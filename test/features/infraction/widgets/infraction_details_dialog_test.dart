import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/infraction/infraction.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
// Removed unnecessary direct controller import; available via infraction.dart barrel

void main() {
  group('InfractionDetailsDialog', () {
    testWidgets('opens and shows details with actions', (tester) async {
      final infraction = Infraction(
        id: 5,
        nom: 'Alpha',
        date: '2024-01-01',
        adresse: 'Rue 1',
        commune_id: 1,
        violant_id: 2,
        agent_id: 3,
        categorie_id: 4,
        latitude: 10.5,
        longitude: -7.2,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => InfractionDetailsDialog(
                      infraction: infraction,
                      controller: InfractionController(),
                      infractionIndex: 0,
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
      expect(find.text('Date: 2024-01-01'), findsOneWidget);
      expect(find.text('Adresse: Rue 1'), findsOneWidget);
      expect(find.text('Commune: 1'), findsOneWidget);
      expect(find.text('Violant: 2'), findsOneWidget);
      expect(find.text('Agent: 3'), findsOneWidget);
      expect(find.text('Catégorie: 4'), findsOneWidget);
      expect(find.text('Latitude: 10.5'), findsOneWidget);
      expect(find.text('Longitude: -7.2'), findsOneWidget);

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
