import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('Testing API connection...');

  try {
    final response = await http.get(
      Uri.parse('https://infraction-commune-api.onrender.com/api/agent'),
      headers: {'Content-Type': 'application/json'},
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body.substring(0, 200)}...');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Number of agents: ${data.length}');
      print('First agent: ${data[0]}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
