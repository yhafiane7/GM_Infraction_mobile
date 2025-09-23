import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/commune/commune.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
// Removed unnecessary direct controller import; available via commune.dart barrel

void main() {
  group('CommuneDetailsDialog', () {
    testWidgets('opens and shows details with actions', (tester) async {
      final commune = Commune(
        id: 42,
        nom: 'Alpha',
        caidat: 'C-A',
        pachalikcircon: 'P-A',
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
                    builder: (_) => CommuneDetailsDialog(
                      commune: commune,
                      controller: CommuneController(),
                      communeIndex: 0,
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
      expect(find.text('Caidat: C-A'), findsOneWidget);
      expect(find.text('Pachalik/Circon: P-A'), findsOneWidget);
      expect(find.text('Latitude: 10.5'), findsOneWidget);
      expect(find.text('Longitude: -7.2'), findsOneWidget);

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
