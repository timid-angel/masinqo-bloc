import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class ListenerSignupDataSource {
  final String baseUrl = Domain.url;

  Future<bool> signupListener(ListenerSignupDTO listener) async {
    final url = Uri.parse('$baseUrl/auth/listener/signup');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': listener.name,
          'email': listener.email,
          'password': listener.password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
