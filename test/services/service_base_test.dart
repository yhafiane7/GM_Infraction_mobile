import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import '../test_helpers/test_data_generator.dart';
import '../test_helpers/mock_responses.dart';

// Generate mocks for http.Client
@GenerateMocks([http.Client])
import 'service_base_test.mocks.dart';

void main() {
  group('ApiClient Tests', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    group('fetchData', () {
      test('should return list of agents when API call succeeds', () async {
        // Arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => MockResponses.successfulAgentList(),
        );

        // Act
        final result = await ApiClient.fetchDataWithClient<Agent>(
          mockClient,
          (json) => Agent.fromJson(json),
        );

        // Assert
        expect(result, isA<List<Agent>>());
        expect(result.length, 2);
        expect(result[0].nom, 'Doe');
        expect(result[1].nom, 'Smith');
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => MockResponses.serverError(),
        );

        // Act & Assert
        expect(
          () => ApiClient.fetchDataWithClient<Agent>(
            mockClient,
            (json) => Agent.fromJson(json),
          ),
          throwsException,
        );
      });
    });

    group('getData', () {
      test('should return single agent when API call succeeds', () async {
        // Arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => MockResponses.successfulSingleAgent(),
        );

        // Act
        final result = await ApiClient.getDataWithClient<Agent>(
          mockClient,
          1,
          (json) => Agent.fromJson(json),
        );

        // Assert
        expect(result, isA<Agent>());
        expect(result.nom, 'Doe');
        expect(result.prenom, 'John');
      });

      test('should throw exception when agent not found', () async {
        // Arrange
        when(mockClient.get(any)).thenAnswer(
          (_) async => MockResponses.notFound(),
        );

        // Act & Assert
        expect(
          () => ApiClient.getDataWithClient<Agent>(
            mockClient,
            999,
            (json) => Agent.fromJson(json),
          ),
          throwsException,
        );
      });
    });

    group('postData', () {
      test('should return success message when agent creation succeeds',
          () async {
        // Arrange
        final testAgent = Agent(
          nom: 'Doe',
          prenom: 'John',
          tel: '1234567890',
          cin: 'AB123456',
        );

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => MockResponses.successfulAgentCreation());

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, testAgent);

        // Assert
        expect(result, 'Agent created successfully');
      });

      test('should return validation error message when validation fails',
          () async {
        // Arrange
        final invalidAgent = Agent(
          nom: '', // Invalid: empty name
          prenom: 'John',
          tel: '123', // Invalid: wrong length
          cin: 'AB123456',
        );

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => MockResponses.validationError());

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, invalidAgent);

        // Assert
        expect(result, contains('Validation failed'));
      });
    });
  });
}
