import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

void main() async {
  developer.log('Testing API connection...');

  try {
    final response = await http.get(
      Uri.parse('https://infraction-commune-api.onrender.com/api/agent'),
      headers: {'Content-Type': 'application/json'},
    );

    developer.log('Status Code: ${response.statusCode}');
    developer.log('Response Body: ${response.body.substring(0, 200)}...');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      developer.log('Number of agents: ${data.length}');
      developer.log('First agent: ${data[0]}');
    }
  } catch (e) {
    developer.log('Error: $e');
  }
}
