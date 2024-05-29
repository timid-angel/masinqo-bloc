import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masinqo/domain/entities/albums.dart';

class ListenerFavService {
  final String baseUrl = "http://localhost:3000";
  // final String token;
  ListenerFavService();

  Future<List<Album>> getFavorites(String token) async {
    final response =
        await http.get(Uri.parse('$baseUrl/listener/favorites'), headers: {
      "Cookie": token,
    });
    // print(response.body);
    if (response.statusCode == 200) {
      Iterable lists = json.decode(response.body);
      return List<Album>.from(lists.map((model) => Album.fromJson(model)));
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> addFavorite(String id, String token) async {
    final response = await http.post(Uri.parse('$baseUrl/listener/favorites'),
        headers: {
          "Cookie": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"id": id}));
    if (response.statusCode != 200) {
      throw Exception('Failed to add favorite');
    }
  }

  Future<void> deleteFavorite(String id, String token) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/listener/favorites/$id'), headers: {
      "Cookie": token,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to delete favorite');
    }
  }
}
