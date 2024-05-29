import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/playlist.dart';

class ListenerPlaylistService {
  final String baseUrl = "http://localhost:3000";
  // final String token;
  ListenerPlaylistService();

  Future<List<Playlist>> getPlaylists(String token) async {
    final response = await http.get(Uri.parse('$baseUrl/playlists'), headers: {
      "Cookie": token,
    });
    print(response.body);

    // print(response.body);
    if (response.statusCode == 200) {
      Iterable lists = json.decode(response.body);
      return List<Playlist>.from(
          lists.map((model) => Playlist.fromJson(model)));
    } else {
      throw Exception('Failed to load playlists');
    }
  }

  Future<void> addPlaylist(String playlistName, String token) async {
    final response = await http.post(Uri.parse('$baseUrl/playlists'),
        headers: {
          "Cookie": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(playlistName));
    if (response.statusCode != 201) {
      throw Exception('Failed to create playlist');
    }
  }

  Future<void> editPlaylist(String id, String name, String token) async {
    final response = await http.put(Uri.parse('$baseUrl/playlists/$id'),
        headers: {
          "Cookie": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode(name));
    if (response.statusCode != 200) {
      throw Exception('Failed to edit playlist');
    }
  }
}
