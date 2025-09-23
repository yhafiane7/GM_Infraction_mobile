import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/infraction/infraction.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';

void main() {
  group('InfractionViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
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

      await tester.pumpWidget(
        MaterialApp(
          home: InfractionViewWidget(
            communes: communes,
            violants: violants,
            agents: agents,
            categories: categories,
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter une Infraction'), findsOneWidget);
      expect(find.byType(InfractionFormWidget), findsOneWidget);
    });
  });
}
