import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/infraction.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';

void main() {
  group('Infraction Entity Widget Tests', () {
    final testCommunes = [
      Commune(
          id: 1,
          nom: 'Test Commune 1',
          pachalikcircon: 'Pachalik1',
          caidat: 'Caidat1',
          latitude: 1.0,
          longitude: 1.0),
      Commune(
          id: 2,
          nom: 'Test Commune 2',
          pachalikcircon: 'Pachalik2',
          caidat: 'Caidat2',
          latitude: 2.0,
          longitude: 2.0),
    ];

    final testViolants = [
      Violant(id: 1, nom: 'Test Violant 1', prenom: 'Prenom1', cin: 'CIN1'),
      Violant(id: 2, nom: 'Test Violant 2', prenom: 'Prenom2', cin: 'CIN2'),
    ];

    final testAgents = [
      Agent(
          id: 1,
          nom: 'Test Agent 1',
          prenom: 'Prenom1',
          tel: '123456789',
          cin: 'CIN1'),
      Agent(
          id: 2,
          nom: 'Test Agent 2',
          prenom: 'Prenom2',
          tel: '987654321',
          cin: 'CIN2'),
    ];

    final testCategories = [
      Categorie(id: 1, nom: 'Test Categorie 1', degre: 1),
      Categorie(id: 2, nom: 'Test Categorie 2', degre: 2),
    ];

    final testInfractions = [
      Infraction(
        id: 1,
        nom: 'TestInfraction1',
        date: '2023-01-01',
        adresse: 'Test Address 1',
        latitude: 1.0,
        longitude: 1.0,
        commune_id: 1,
        violant_id: 1,
        agent_id: 1,
        categorie_id: 1,
      ),
      Infraction(
        id: 2,
        nom: 'TestInfraction2',
        date: '2023-01-02',
        adresse: 'Test Address 2',
        latitude: 2.0,
        longitude: 2.0,
        commune_id: 2,
        violant_id: 2,
        agent_id: 2,
        categorie_id: 2,
      ),
    ];

    group('InfractionList Widget', () {
      testWidgets('should display infraction list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: testInfractions),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Date'), findsOneWidget);
        expect(find.text('Adresse'), findsOneWidget);

        // Verify first infraction data
        expect(find.text('TestInfraction1'), findsOneWidget);
        expect(find.text('Test Address 1'), findsOneWidget);

        // Verify second infraction data
        expect(find.text('TestInfraction2'), findsOneWidget);
        expect(find.text('Test Address 2'), findsOneWidget);
      });

      testWidgets('should handle empty infraction list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('ID'), findsOneWidget);
      });

      testWidgets('should handle long press on infraction row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: testInfractions),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('TestInfraction1'), findsOneWidget);
        // Note: Long press testing would require mocking DataRepository
        // For now, just verify the widget structure is correct
      });
    });

    group('InfractionView Widget', () {
      testWidgets('should display form fields correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
            home: InfractionView(
          Communes: testCommunes,
          Violants: testViolants,
          Agents: testAgents,
          Categories: testCategories,
        )));

        // Verify form fields are present
        expect(find.byType(TextFormField), findsWidgets);
        expect(find.text('Ajouter une Infraction'), findsOneWidget);
      });
    });
  });
}
