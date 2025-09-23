import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/agent/agent.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
// Removed unnecessary direct controller import; available via agent.dart barrel

class _RecordingAgentController extends AgentController {
  int? lastIndex;
  Agent? lastAgent;
  @override
  Future<String> updateAgent(int index, Agent agent) async {
    lastIndex = index;
    lastAgent = agent;
    return 'Data updated successfully';
  }
}

Future<void> _openEditDialog(
  WidgetTester tester, {
  required Agent agent,
  required AgentController controller,
  required int agentIndex,
  Function(int, Agent)? onUpdated,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AgentEditDialog(
                  agent: agent,
                  controller: controller,
                  agentIndex: agentIndex,
                  onAgentUpdated: onUpdated,
                ),
              );
            },
            child: const Text('OpenEdit'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('OpenEdit'));
  await tester.pumpAndSettle();
}

void main() {
  group('AgentEditDialog', () {
    testWidgets('renders fields with initial values', (tester) async {
      final agent = Agent(
        id: 10,
        nom: 'InitN',
        prenom: 'InitP',
        cin: 'AB123456',
        tel: '0123456789',
      );
      final controller = _RecordingAgentController();

      await _openEditDialog(
        tester,
        agent: agent,
        controller: controller,
        agentIndex: 0,
      );

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.widgetWithText(TextFormField, 'InitN'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'InitP'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'AB123456'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '0123456789'), findsOneWidget);
      expect(find.text('Enregistrer'), findsOneWidget);
    });

    testWidgets('submits update and calls controller and callback',
        (tester) async {
      final agent = Agent(
        id: 9,
        nom: 'Old',
        prenom: 'OP',
        cin: 'ZZ111111',
        tel: '0999999999',
      );
      final controller = _RecordingAgentController();

      int? cbIndex;
      Agent? cbAgent;

      await _openEditDialog(
        tester,
        agent: agent,
        controller: controller,
        agentIndex: 3,
        onUpdated: (i, a) {
          cbIndex = i;
          cbAgent = a;
        },
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'New');
      await tester.enterText(find.byType(TextFormField).at(1), 'NP');
      await tester.enterText(find.byType(TextFormField).at(2), 'CD789012');
      await tester.enterText(find.byType(TextFormField).at(3), '0123456780');

      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer'), findsNothing);

      expect(controller.lastIndex, 3);
      expect(controller.lastAgent, isNotNull);
      expect(controller.lastAgent!.nom, 'New');
      expect(controller.lastAgent!.prenom, 'NP');
      expect(controller.lastAgent!.cin, 'CD789012');
      expect(controller.lastAgent!.tel, '0123456780');

      expect(cbIndex, 3);
      expect(cbAgent, isNotNull);
      expect(cbAgent!.nom, 'New');
    });
  });
}
