import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ServiceBase {
  static const String baseUrl = 'http://192.168.1.157:8000/api';
  static Future<List<T>> fetchData<T>(
    http.Client client,
    String route,
    T Function(dynamic) fromJson,
  ) async { 
    final response = await client.get(Uri.parse(baseUrl+'/' + route));
    return parseData<T>(response.body, fromJson);
  }

  static List<T> parseData<T>(
      String responseBody, T Function(dynamic) fromJson) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<T>((json) => fromJson(json)).toList();
  }

  //------------------------------------get Data from api-------------------------------------------------------//
  static Future<T> getData<T>(
      int index, T Function(Map<String, dynamic>) fromJson) async {
    String objectType = T.toString().toLowerCase();
    final response = await http.get(Uri.parse('$baseUrl/$objectType/$index'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch Data');
    }
  }

  // --------------------------------create a record in database from an object given----------------------------//
  static Future<String> create(Object AnyObject) async {
    String toSend = jsonEncode(AnyObject);
    String objectType = (AnyObject.runtimeType).toString().toLowerCase();
    
    print(baseUrl);
    print(toSend);
    final response = await http.post(Uri.parse("$baseUrl/$objectType"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: toSend);
    if (response.statusCode == 200) {
      return ('Bien Fait');
    } else {
      // Request failed with an error
      // Parse the response body as JSON
      final jsonResponse = json.decode(response.body);

      // Get the error message from the JSON response
      final errors = jsonResponse['errors'];
      if (errors != null) {
        final errorMessages = errors.values.toList();
        if (errorMessages.isNotEmpty) {
          final firstErrorMessage = errorMessages[0][0];
          return firstErrorMessage.toString();
        }
      } else {
        // Response body is empty or not in JSON format
        return 'Request failed with status: ${response.statusCode}';
      }
      // Request failed
      return 'Request failed with status: ${response.statusCode}';
    }
  }

  //------------------------update a record-------------------//
  static Future<String> update(int index, Object AnyObject) async {
    String toSend = jsonEncode(AnyObject);
    String objectType = (AnyObject.runtimeType).toString().toLowerCase();
    print(toSend);
    final response = await http.patch(Uri.parse("$baseUrl/$objectType/$index"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: toSend);
    if (response.statusCode == 200) {
      return ('Bien Fait');
    } else {
      // Request failed with an error
      if (response.body != null) {
        // Parse the response body as JSON
        final jsonResponse = json.decode(response.body);

        // Get the error message from the JSON response
        return jsonResponse['errors'];
      } else {
        // Response body is empty or not in JSON format
        return 'Request failed with status: ${response.statusCode}';
      }
      // Request failed
    }
  }

// --------------------------------delete a record in database from an index and object given----------------------------//
  static Future<String> delete(int index, Object AnyObject) async {
    String objectType = (AnyObject.runtimeType).toString().toLowerCase();
    String url = "$baseUrl/$objectType/$index";

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: jsonResponse['Message'] ?? 'Deleted successfully',
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
      return 'Deleted successfully';
    } else {
      return 'Failed to delete: ${response.statusCode}';
    }
  }

}
