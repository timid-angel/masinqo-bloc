import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class ListenerAlbumService {
  // final String baseUrl = "http://localhost:3000";
  final String baseUrl = Domain.url;

  ListenerAlbumService();

  Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums/public'));
    if (response.statusCode == 200) {
      Iterable lists = json.decode(response.body);
      return List<Album>.from(lists.map((model) => Album.fromJson(model)));
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
