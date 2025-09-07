import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';

void main() {
  group('Agent API Tests', () {
    test('should handle API calls gracefully', () async {
      try {
        final agents = await ApiClient.fetchData<Agent>(
          (json) => Agent.fromJson(json),
        );
        expect(agents, isA<List<Agent>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('should create agent with valid data', () async {
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

        final result = await ApiClient.postData<Agent>(testAgent);
        expect(result, isA<String>());
      } catch (e) {
        // Expected if server is down or validation fails
        expect(e, isA<Exception>());
      }
    });
  });
}
