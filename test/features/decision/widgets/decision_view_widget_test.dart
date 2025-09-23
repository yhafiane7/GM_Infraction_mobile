import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart';

void main() {
  group('DecisionViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DecisionViewWidget(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter une Décision'), findsOneWidget);
      expect(find.byType(DecisionFormWidget), findsOneWidget);
    });
  });
}
