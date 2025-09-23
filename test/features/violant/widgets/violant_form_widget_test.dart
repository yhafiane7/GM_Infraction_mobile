import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/violant/violant.dart';
// Removed unnecessary direct controller import; available via violant.dart barrel

void main() {
  group('ViolantFormWidget', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViolantFormWidget(controller: ViolantController()),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViolantFormWidget(controller: ViolantController()),
          ),
        ),
      );

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer Le Nom'), findsOneWidget);
      expect(find.text('SVP entrer Le Prénom'), findsOneWidget);
      expect(find.text('SVP entrer Le CIN'), findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViolantFormWidget(controller: ViolantController()),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(1), 'John');
      await tester.enterText(find.byType(TextFormField).at(2), 'VI123456');

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Violant Details:'), findsOneWidget);
      expect(find.text('Nom: Doe'), findsOneWidget);
      expect(find.text('Prenom: John'), findsOneWidget);
      expect(find.text('CIN: VI123456'), findsOneWidget);
    });
  });
}
