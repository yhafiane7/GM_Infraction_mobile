import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/agent/agent.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
// Removed unnecessary direct controller import; available via agent.dart barrel

void main() {
  group('AgentListWidget', () {
    final testAgents = [
      Agent(
          id: 1,
          nom: 'Doe',
          prenom: 'John',
          tel: '0123456789',
          cin: 'AB123456'),
      Agent(
          id: 2,
          nom: 'Smith',
          prenom: 'Jane',
          tel: '0987654321',
          cin: 'CD789012'),
    ];

    testWidgets('displays table headers and rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AgentListWidget(
              agents: testAgents,
              controller: AgentController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Prénom'), findsOneWidget);
      expect(find.text('CIN'), findsOneWidget);
      expect(find.text('N.Télé'), findsOneWidget);

      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('Smith'), findsOneWidget);
    });

    testWidgets('handles empty list without controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AgentListWidget(agents: []),
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
            body: AgentListWidget(
              agents: testAgents,
              controller: AgentController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Doe'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: Doe'), findsOneWidget);
      expect(find.text('Prénom: John'), findsOneWidget);
      expect(find.text('CIN: AB123456'), findsOneWidget);
    });
  });
}
