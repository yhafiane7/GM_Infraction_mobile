import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';

import 'api_client_comprehensive_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiClient Comprehensive Tests', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    group('fetchDataWithClient', () {
      test('should fetch data successfully', () async {
        // Arrange
        final mockResponse = http.Response('''
        [
          {"id": 1, "nom": "Test Agent", "prenom": "Test", "tel": "1234567890", "cin": "AB123456"},
          {"id": 2, "nom": "Test Agent 2", "prenom": "Test 2", "tel": "0987654321", "cin": "CD789012"}
        ]
        ''', 200);

        when(mockClient.get(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await ApiClient.fetchDataWithClient<Agent>(
          mockClient,
          (json) => Agent.fromJson(json),
        );

        // Assert
        expect(result, isA<List<Agent>>());
        expect(result.length, equals(2));
        expect(result[0].nom, equals('Test Agent'));
        expect(result[1].nom, equals('Test Agent 2'));
        verify(mockClient.get(any)).called(1);
      });

      test('should throw exception on non-200 status code', () async {
        // Arrange
        final mockResponse = http.Response('Error', 404);
        when(mockClient.get(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => ApiClient.fetchDataWithClient<Agent>(
            mockClient,
            (json) => Agent.fromJson(json),
          ),
          throwsException,
        );
      });

      test('should handle network errors', () async {
        // Arrange
        when(mockClient.get(any)).thenThrow(Exception('Network error'));

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

    group('getDataWithClient', () {
      test('should get single data item successfully', () async {
        // Arrange
        final mockResponse = http.Response('''
        {"id": 1, "nom": "Test Agent", "prenom": "Test", "tel": "1234567890", "cin": "AB123456"}
        ''', 200);

        when(mockClient.get(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await ApiClient.getDataWithClient<Agent>(
          mockClient,
          1,
          (json) => Agent.fromJson(json),
        );

        // Assert
        expect(result, isA<Agent>());
        expect(result.nom, equals('Test Agent'));
        verify(mockClient.get(any)).called(1);
      });

      test('should throw exception on non-200 status code', () async {
        // Arrange
        final mockResponse = http.Response('Not Found', 404);
        when(mockClient.get(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => ApiClient.getDataWithClient<Agent>(
            mockClient,
            1,
            (json) => Agent.fromJson(json),
          ),
          throwsException,
        );
      });
    });

    group('postDataWithClient', () {
      test('should post data successfully with 201 status', () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse = http.Response('''
        {"message": "Agent created successfully", "data": {"id": 1, "nom": "Test", "prenom": "Agent", "tel": "1234567890", "cin": "AB123456"}}
        ''', 201);

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, agent);

        // Assert
        expect(result, equals('Agent created successfully'));
        verify(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .called(1);
      });

      test('should post data successfully with 200 status', () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse = http.Response('{"message": "Success"}', 200);

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, agent);

        // Assert
        expect(result, equals('Success'));
      });

      test('should return default message when no message in response',
          () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse = http.Response('{"data": {"id": 1}}', 201);

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, agent);

        // Assert
        expect(result, equals('Data posted successfully'));
      });

      test('should handle error response', () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse = http.Response('''
        {"message": "Validation failed", "errors": {"nom": ["The nom field is required."]}}
        ''', 400);

        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, agent);

        // Assert
        expect(result, equals('Validation failed'));
      });
    });

    group('updateDataWithClient', () {
      test('should update data successfully', () async {
        // Arrange
        final agent = Agent(
            nom: 'Updated',
            prenom: 'Agent',
            tel: '1234567890',
            cin: 'AB123456');
        final mockResponse =
            http.Response('{"message": "Updated successfully"}', 200);

        when(mockClient.put(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.updateDataWithClient<Agent>(mockClient, 1, agent);

        // Assert
        expect(result, equals('Data updated successfully'));
        verify(mockClient.put(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .called(1);
      });

      test('should handle error response', () async {
        // Arrange
        final agent = Agent(
            nom: 'Updated',
            prenom: 'Agent',
            tel: '1234567890',
            cin: 'AB123456');
        final mockResponse = http.Response('{"message": "Not found"}', 404);

        when(mockClient.put(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.updateDataWithClient<Agent>(mockClient, 1, agent);

        // Assert
        expect(result, equals('Not found'));
      });
    });

    group('deleteDataWithClient', () {
      test('should delete data successfully', () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse =
            http.Response('{"message": "Deleted successfully"}', 200);

        when(mockClient.delete(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.deleteDataWithClient<Agent>(mockClient, 1, agent);

        // Assert
        expect(result, equals('Data deleted successfully'));
        verify(mockClient.delete(any, headers: anyNamed('headers'))).called(1);
      });

      test('should handle error response', () async {
        // Arrange
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final mockResponse = http.Response('{"message": "Not found"}', 404);

        when(mockClient.delete(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result =
            await ApiClient.deleteDataWithClient<Agent>(mockClient, 1, agent);

        // Assert
        expect(result, equals('Not found'));
      });
    });

    group('Error Handling', () {
      test('should handle JSON parsing errors', () async {
        // Arrange
        final mockResponse = http.Response('Invalid JSON', 200);
        when(mockClient.get(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => ApiClient.fetchDataWithClient<Agent>(
            mockClient,
            (json) => Agent.fromJson(json),
          ),
          throwsException,
        );
      });

      test('should handle empty response body', () async {
        // Arrange
        final mockResponse = http.Response('', 400);
        when(mockClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final agent = Agent(
            nom: 'Test', prenom: 'Agent', tel: '1234567890', cin: 'AB123456');
        final result =
            await ApiClient.postDataWithClient<Agent>(mockClient, agent);

        // Assert
        expect(result, contains('Request failed with status: 400'));
      });
    });
  });
}
