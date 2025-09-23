import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/agent/agent.dart';
// Removed unnecessary direct controller import; available via agent.dart barrel

void main() {
  group('AgentFormWidget', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AgentFormWidget(controller: AgentController()),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required fields and formats', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AgentFormWidget(controller: AgentController()),
          ),
        ),
      );

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer Le Nom'), findsOneWidget);
      expect(find.text('SVP entrer Le Prénom'), findsOneWidget);
      expect(find.text('SVP entrer Le CIN'), findsOneWidget);
      expect(find.text('SVP entrer Le N°Téle'), findsOneWidget);

      // Enter invalid CIN and phone
      await tester.enterText(find.byType(TextFormField).at(2), 'invalid-cin!');
      await tester.enterText(find.byType(TextFormField).at(3), '123');
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(
          find.text('Le CIN ne doit pas dépasser 12 caractères'), findsNothing);
      expect(
          find.text(
              'Le CIN ne doit contenir que des lettres majuscules et des chiffres'),
          findsOneWidget);
      expect(find.text('Le numéro doit contenir exactement 10 chiffres'),
          findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AgentFormWidget(controller: AgentController()),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(1), 'John');
      await tester.enterText(find.byType(TextFormField).at(2), 'AB123456');
      await tester.enterText(find.byType(TextFormField).at(3), '0123456789');

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Agent Details:'), findsOneWidget);
      expect(find.text('Nom: Doe'), findsOneWidget);
      expect(find.text('Prenom: John'), findsOneWidget);
      expect(find.text('Tel: 0123456789'), findsOneWidget);
      expect(find.text('CIN: AB123456'), findsOneWidget);
    });
  });
}
