import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class ArtistSignupDataSource {
  final String baseUrl = Domain.url;

  Future<bool> signupArtist(ArtistSignupDTO artist) async {
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
      return false;
    }
  }
}