import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'test_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('postDataWithClient', () {
    late TestClient client;

    setUp(() {
      client = TestClient();
    });

    test('returns success message on 200', () async {
      client.postResponse = http.Response('{"message":"created"}', 200);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.postDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        object: agent,
      );

      expect(result, 'created');
    });

    test('handles error response', () async {
      client.postResponse = http.Response('{"message":"fail"}', 400);

      final agent = Agent(id: 1, nom: 'A', prenom: 'B', tel: '123', cin: 'X');
      final result = await ApiClient.postDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        object: agent,
      );

      expect(result, 'fail');
    });
  });
}
