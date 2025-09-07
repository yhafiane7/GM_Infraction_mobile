import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiClient {
  static String get baseUrl => AppConfig.currentBaseUrl;

  //------------------------------------fetch Data from api-------------------------------------------------------//
  static Future<List<T>> fetchData<T>(
      T Function(Map<String, dynamic>) fromJson) async {
    return fetchDataWithClient(http.Client(), fromJson);
  }

  static Future<List<T>> fetchDataWithClient<T>(
      http.Client client, T Function(Map<String, dynamic>) fromJson) async {
    String endpoint = T.toString().toLowerCase();
    final response = await client.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to fetch Data: ${response.statusCode} - ${response.body}');
    }
  }

  //------------------------------------get Data from api-------------------------------------------------------//
  static Future<T> getData<T>(
      int index, T Function(Map<String, dynamic>) fromJson) async {
    return getDataWithClient(http.Client(), index, fromJson);
  }

  static Future<T> getDataWithClient<T>(http.Client client, int index,
      T Function(Map<String, dynamic>) fromJson) async {
    String endpoint = T.toString().toLowerCase();
    final response = await client.get(Uri.parse('$baseUrl/$endpoint/$index'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch Data');
    }
  }

  //------------------------------------post Data to api-------------------------------------------------------//
  static Future<String> postData<T>(T object) async {
    return postDataWithClient(http.Client(), object);
  }

  static Future<String> postDataWithClient<T>(
      http.Client client, T object) async {
    String endpoint = T.toString().toLowerCase();
    final url = '$baseUrl/$endpoint';
    final body = jsonEncode(object);

    print('POST Request to: $url');
    print('Request body: $body');

    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Parse the response to get the message
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] != null) {
          return jsonResponse['message'].toString();
        }
      } catch (e) {
        // If parsing fails, return default message
      }
      return 'Data posted successfully';
    } else {
      return _handleErrorResponse(response);
    }
  }

  //------------------------------------update Data to api-------------------------------------------------------//
  static Future<String> updateData<T>(int index, T object) async {
    return updateDataWithClient(http.Client(), index, object);
  }

  static Future<String> updateDataWithClient<T>(
      http.Client client, int index, T object) async {
    String endpoint = T.toString().toLowerCase();
    final response = await client.put(
      Uri.parse('$baseUrl/$endpoint/$index'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(object),
    );

    if (response.statusCode == 200) {
      return 'Data updated successfully';
    } else {
      return _handleErrorResponse(response);
    }
  }

  //------------------------------------delete Data from api-------------------------------------------------------//
  static Future<String> deleteData<T>(int index, T object) async {
    return deleteDataWithClient(http.Client(), index, object);
  }

  static Future<String> deleteDataWithClient<T>(
      http.Client client, int index, T object) async {
    String endpoint = T.toString().toLowerCase();
    final response = await client.delete(
      Uri.parse('$baseUrl/$endpoint/$index'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return 'Data deleted successfully';
    } else {
      return _handleErrorResponse(response);
    }
  }

  //------------------------------------handle Error Response-------------------------------------------------------//
  static String _handleErrorResponse(http.Response response) {
    if (response.body.isNotEmpty) {
      try {
        // Parse the response body as JSON
        final jsonResponse = json.decode(response.body);

        // Handle different error response formats based on API documentation
        if (jsonResponse['message'] != null) {
          return jsonResponse['message'].toString();
        } else if (jsonResponse['errors'] != null) {
          final errors = jsonResponse['errors'];
          if (errors is String) {
            return errors;
          } else if (errors is Map<String, dynamic>) {
            // Convert validation errors to a readable string
            final errorMessages = <String>[];
            errors.forEach((field, messages) {
              if (messages is List) {
                errorMessages.addAll(messages.map((msg) => '$field: $msg'));
              } else {
                errorMessages.add('$field: $messages');
              }
            });
            return errorMessages.join(', ');
          } else {
            return errors.toString();
          }
        } else {
          return 'Request failed with status: ${response.statusCode}';
        }
      } catch (e) {
        return 'Request failed with status: ${response.statusCode} - ${response.body}';
      }
    } else {
      // Response body is empty or not in JSON format
      return 'Request failed with status: ${response.statusCode}';
    }
  }
}
