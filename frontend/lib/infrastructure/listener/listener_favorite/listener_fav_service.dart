import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masinqo/domain/entities/albums.dart';

class ListenerFavService {
  final String baseUrl = "http://localhost:3000";
  final String token;
  ListenerFavService({required this.token});

  Future<List<Album>> getFavorites() async {
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
}
