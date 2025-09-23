import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/violant/violant.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
// Removed unnecessary direct controller import; available via violant.dart barrel

void main() {
  group('ViolantListWidget', () {
    final testViolants = [
      Violant(id: 1, nom: 'V1', prenom: 'P1', cin: 'C1'),
      Violant(id: 2, nom: 'V2', prenom: 'P2', cin: 'C2'),
    ];

    testWidgets('displays table headers and rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViolantListWidget(
              violants: testViolants,
              controller: ViolantController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Prénom'), findsOneWidget);
      expect(find.text('CIN'), findsOneWidget);

      expect(find.text('V1'), findsOneWidget);
      expect(find.text('V2'), findsOneWidget);
    });

    testWidgets('handles empty list without controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ViolantListWidget(violants: []),
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
            body: ViolantListWidget(
              violants: testViolants,
              controller: ViolantController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('V1'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: V1'), findsOneWidget);
      expect(find.text('Prénom: P1'), findsOneWidget);
      expect(find.text('CIN: C1'), findsOneWidget);
    });
  });
}
