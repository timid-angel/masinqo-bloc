
// listener_login_datasource.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListenerLoginDataSource {
  final String baseUrl;

  ListenerLoginDataSource({required this.baseUrl});

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/listener/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }

    // Handle successful login response if needed
  }
}
