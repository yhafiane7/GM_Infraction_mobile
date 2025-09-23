import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/infraction/infraction.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/features/infraction/controllers/infraction_controller.dart';

void main() {
  group('InfractionListWidget', () {
    final testInfractions = [
      Infraction(
        id: 1,
        nom: 'I1',
        date: '2024-01-01',
        adresse: 'A1',
        commune_id: 1,
        violant_id: 2,
        agent_id: 3,
        categorie_id: 4,
        latitude: 1.1,
        longitude: 2.2,
      ),
      Infraction(
        id: 2,
        nom: 'I2',
        date: '2024-01-02',
        adresse: 'A2',
        commune_id: 5,
        violant_id: 6,
        agent_id: 7,
        categorie_id: 8,
        latitude: 3.3,
        longitude: 4.4,
      ),
    ];

    testWidgets('displays table headers and rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfractionListWidget(
              infractions: testInfractions,
              controller: InfractionController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Adresse'), findsOneWidget);
      expect(find.text('Latitude'), findsOneWidget);
      expect(find.text('Longitude'), findsOneWidget);

      expect(find.text('I1'), findsOneWidget);
      expect(find.text('I2'), findsOneWidget);
    });

    testWidgets('handles empty list without controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfractionListWidget(infractions: []),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
    });

    testWidgets('long press opens details dialog when controller provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfractionListWidget(
              infractions: testInfractions,
              controller: InfractionController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('I1'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: I1'), findsOneWidget);
      expect(find.text('Date: 2024-01-01'), findsOneWidget);
      expect(find.text('Adresse: A1'), findsOneWidget);
    });
  });
}
