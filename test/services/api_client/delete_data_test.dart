import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'test_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('deleteDataWithClient', () {
    late TestClient client;

    setUp(() {
      client = TestClient();
    });

    test('returns success message on 200', () async {
      client.deleteResponse = http.Response('', 200);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.deleteDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        index: 1,
        object: agent,
      );

      expect(result, 'Data deleted successfully');
    });

    test('handles error response', () async {
      client.deleteResponse = http.Response('{"message":"fail"}', 400);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.deleteDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        index: 1,
        object: agent,
      );

      expect(result, 'fail');
    });
  });
}
