import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'test_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('updateDataWithClient', () {
    late TestClient client;

    setUp(() {
      client = TestClient();
    });

    test('returns success message on 200', () async {
      client.putResponse = http.Response('', 200);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.updateDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        index: 1,
        object: agent,
      );

      expect(result, 'Data updated successfully');
    });

    test('handles error response', () async {
      client.putResponse = http.Response('{"message":"fail"}', 400);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.updateDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        index: 1,
        object: agent,
      );

      expect(result, 'fail');
    });
  });
}
