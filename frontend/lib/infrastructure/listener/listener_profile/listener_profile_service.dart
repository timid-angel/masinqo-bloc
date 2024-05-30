import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masinqo/domain/entities/profile.dart';

class ListenerProfileService {
  final String baseUrl = "http://localhost:3000";
  // final String token;
  ListenerProfileService();

  Future<Profile> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/listener/info'),
      headers: {
        "Cookie": "accessToken=$token",
        "Content-Type": "application/json"
      },
    );
    print("get response.body: ${response.body}");
    if (response.statusCode == 200) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> editProfile(
      String token, String name, String email, String password) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/listener/update'),
      headers: {
        "Cookie": "accessToken=$token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    print("edit fav service");
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to load profile');
    }
  }
}
