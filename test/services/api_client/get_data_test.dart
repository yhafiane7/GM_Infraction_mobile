import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'test_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('getDataWithClient', () {
    late TestClient client;

    setUp(() {
      client = TestClient();
    });

    test('returns item on 200', () async {
      client.getResponse = http.Response(
          '{"id":1,"nom":"A","prenom":"B","tel":"1234567890","cin":"X1"}',
          200);

      final result = await ApiClient.getDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        index: 1,
        fromJson: (json) => Agent.fromJson(json),
      );

      expect(result, isA<Agent>());
      expect(result.nom, 'A');
    });

    test('throws exception on non-200', () async {
      client.getResponse = http.Response('NF', 404);

      expect(
        () => ApiClient.getDataWithClient<Agent>(
          client: client,
          endpoint: 'agent',
          index: 1,
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });
  });
}
