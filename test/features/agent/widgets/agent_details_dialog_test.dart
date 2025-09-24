import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/agent/agent.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
// Removed unnecessary direct controller import; available via agent.dart barrel

void main() {
  group('AgentDetailsDialog', () {
    testWidgets('opens and shows details with actions', (tester) async {
      final agent = Agent(
        id: 5,
        nom: 'Alpha',
        prenom: 'Beta',
        cin: 'AB123456',
        tel: '0123456789',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AgentDetailsDialog(
                      agent: agent,
                      controller: AgentController(),
                      agentIndex: 0,
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: Alpha'), findsOneWidget);
      expect(find.text('Prénom: Beta'), findsOneWidget);
      expect(find.text('CIN: AB123456'), findsOneWidget);
      expect(find.text('N°Téle: 0123456789'), findsOneWidget);

      expect(find.text('Supprimer'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });
  });
}
