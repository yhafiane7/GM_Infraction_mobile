import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/agent.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';

void main() {
  group('Agent Entity Widget Tests', () {
    final testAgents = [
      Agent(
          id: 1,
          nom: 'Doe',
          prenom: 'John',
          tel: '1234567890',
          cin: 'AB123456'),
      Agent(
          id: 2,
          nom: 'Smith',
          prenom: 'Jane',
          tel: '0987654321',
          cin: 'CD789012'),
    ];

    group('AgentList Widget', () {
      testWidgets('should display agent list with correct data',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AgentList(Agents: testAgents),
            ),
          ),
        );

        // Verify DataTable headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Prénom'), findsOneWidget);
        expect(find.text('CIN'), findsOneWidget);
        expect(find.text('N.Téle'), findsOneWidget);

        // Verify agent data
        expect(find.text('Doe'), findsOneWidget);
        expect(find.text('John'), findsOneWidget);
        expect(find.text('AB123456'), findsOneWidget);
        expect(find.text('1234567890'), findsOneWidget);
      });

      testWidgets('should handle empty agent list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AgentList(Agents: []),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
      });

      testWidgets('should handle long press on agent row',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AgentList(Agents: testAgents),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('Doe'), findsOneWidget);

        // Note: Long press testing would require mocking DataRepository
      });
    });

    group('AgentView Widget', () {
      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: AgentView()));

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('SVP entrer Le Nom'), findsOneWidget);
        expect(find.text('SVP entrer Le Prénom'), findsOneWidget);
        expect(find.text('SVP entrer Le CIN'), findsOneWidget);
        expect(find.text('SVP entrer Le N°Téle'), findsOneWidget);
      });

      testWidgets('should validate CIN format', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: AgentView()));

        final cinField = find.byType(TextFormField).at(2);
        await tester.enterText(cinField, 'invalid-cin');
        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(
            find.text(
                'Le CIN ne doit contenir que des lettres majuscules et des chiffres'),
            findsOneWidget);
      });

      testWidgets('should validate phone number length',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: AgentView()));

        final phoneField = find.byType(TextFormField).at(3);
        await tester.enterText(phoneField, '123');
        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Le numéro doit contenir exactement 10 chiffres'),
            findsOneWidget);
      });

      testWidgets('should submit valid form and show confirmation dialog',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: AgentView()));

        await tester.enterText(find.byType(TextFormField).at(0), 'Doe');
        await tester.enterText(find.byType(TextFormField).at(1), 'John');
        await tester.enterText(find.byType(TextFormField).at(2), 'AB123456');
        await tester.enterText(find.byType(TextFormField).at(3), '1234567890');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        expect(find.text('Confirmation'), findsOneWidget);
        expect(find.text('Nom: Doe'), findsOneWidget);
        expect(find.text('Prenom: John'), findsOneWidget);
        expect(find.text('Tel: 1234567890'), findsOneWidget);
        expect(find.text('CIN: AB123456'), findsOneWidget);
      });

      testWidgets('should cancel dialog', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: AgentView()));

        await tester.enterText(find.byType(TextFormField).at(0), 'Doe');
        await tester.enterText(find.byType(TextFormField).at(1), 'John');
        await tester.enterText(find.byType(TextFormField).at(2), 'AB123456');
        await tester.enterText(find.byType(TextFormField).at(3), '1234567890');

        await tester.tap(find.text('Ajouter'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter un Agent'), findsOneWidget);
      });
    });
  });
}
