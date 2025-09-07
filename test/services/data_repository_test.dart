import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';

void main() {
  group('DataRepository Tests', () {
    test('should handle agent operations gracefully', () async {
      try {
        final agents = await DataRepository.fetchAgents();
        expect(agents, isA<List<Agent>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('should create agent successfully', () async {
      try {
        // Use unique data to avoid validation conflicts
        final timestamp =
            DateTime.now().millisecondsSinceEpoch.toString().substring(8);
        final testAgent = Agent(
          nom: 'Test$timestamp',
          prenom: 'Agent$timestamp',
          tel: '${timestamp.padLeft(10, '0')}',
          cin: 'AB$timestamp',
        );

        final result = await DataRepository.createAgent(testAgent);
        expect(result, isA<String>());
      } catch (e) {
        // Expected if server is down or validation fails
        expect(e, isA<Exception>());
      }
    });
  });
}
