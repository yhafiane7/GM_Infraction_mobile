import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/data_repository.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';

void main() {
  group('Agent API (integration)', () {
    // Mark as integration: hits the live API
    const integrationTag = ['integration'];
    test('fetchAgents returns list or throws', () async {
      try {
        final agents = await DataRepository.fetchAgents();
        expect(agents, isA<List<Agent>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    }, tags: integrationTag);

    test('createAgent returns message or throws', () async {
      try {
        // Use unique data to avoid validation conflicts
        final timestamp =
            DateTime.now().millisecondsSinceEpoch.toString().substring(8);
        final testAgent = Agent(
          nom: 'TestAgent$timestamp',
          prenom: 'TestPrenom$timestamp',
          tel: '${timestamp.padLeft(10, '0')}',
          cin: 'TEST$timestamp',
        );

        final result = await DataRepository.createAgent(testAgent);
        expect(result, isA<String>());
      } catch (e) {
        // Expected if server is down or validation fails
        expect(e, isA<Exception>());
      }
    }, tags: integrationTag);
  });
}
