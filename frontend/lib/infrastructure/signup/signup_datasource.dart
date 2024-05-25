import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/signup/artist.dart';
abstract class SignupDataSource {
  Future<bool> signupArtist(Artist artist, String confirmPassword);
}

class MockSignupDataSource implements SignupDataSource {
  @override
  Future<bool> signupArtist(Artist artist, String confirmPassword) async {
    
    await Future.delayed(Duration(seconds: 2)); 
    return artist.password == confirmPassword;
  }
}

class HttpSignupDataSource implements SignupDataSource {
  final String baseUrl;

  HttpSignupDataSource({required this.baseUrl});

  @override
  Future<bool> signupArtist(Artist artist, String confirmPassword) async {
    final url = Uri.parse('$baseUrl/auth/artist/signup');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': artist.name,
          'email': artist.email,
          'password': artist.password,
        }),
      );



      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error signing up artist: $e');
      return false;
    }
  }
}
