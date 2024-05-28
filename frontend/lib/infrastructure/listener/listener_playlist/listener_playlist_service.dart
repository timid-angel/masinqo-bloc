import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/playlist.dart';

class ListenerPlaylistService {
  final String baseUrl = "http://localhost:3000";
  final String token;
  ListenerPlaylistService({required this.token});

  Future<List<Playlist>> getPlaylists() async {
    final response = await http.get(Uri.parse('$baseUrl/playlists'), headers: {
      "Cookie": token,
    });

    // print(response.body);
    if (response.statusCode == 200) {
      Iterable lists = json.decode(response.body);
      return List<Playlist>.from(
          lists.map((model) => Playlist.fromJson(model)));
    } else {
      throw Exception('Failed to load playlists');
    }
  }
}
