import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/agent/agent.dart';

void main() {
  group('AgentViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AgentViewWidget(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter un Agent'), findsOneWidget);
      expect(find.byType(AgentFormWidget), findsOneWidget);
    });
  });
}
