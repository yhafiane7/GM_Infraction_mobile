import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'test_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('fetchDataWithClient', () {
    late TestClient client;

    setUp(() {
      client = TestClient();
    });

    test('returns list on 200', () async {
      client.getResponse = http.Response(
          '[{"id":1,"nom":"A","prenom":"B","tel":"1234567890","cin":"X1"}]',
          200);

      final result = await ApiClient.fetchDataWithClient<Agent>(
        client: client,
        endpoint: 'agent',
        fromJson: (json) => Agent.fromJson(json),
      );

      expect(result, isA<List<Agent>>());
      expect(result.first.nom, 'A');
    });

    test('throws exception on non-200', () async {
      client.getResponse = http.Response('err', 404);

      expect(
        () => ApiClient.fetchDataWithClient<Agent>(
          client: client,
          endpoint: 'agent',
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });
  });
}
