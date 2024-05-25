import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/signup/listener.dart';
abstract class ListenerSignupDataSource {
  Future<bool> signupListener(Listeners listener, String confirmPassword);
}

class MockListenerSignupDataSource implements ListenerSignupDataSource {
  @override
  Future<bool> signupListener(Listeners listener, String confirmPassword) async {
    
    await Future.delayed(Duration(seconds: 2)); 
    return listener.password == confirmPassword;
  }
}

class HttpListenerSignupDataSource implements ListenerSignupDataSource {
  final String baseUrl;

  HttpListenerSignupDataSource({required this.baseUrl});

  @override
  Future<bool> signupListener(Listeners listener, String confirmPassword) async {
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
      print('Error signing up Listener: $e');
      return false;
    }
  }
}
