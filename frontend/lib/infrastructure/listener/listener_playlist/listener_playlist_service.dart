import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';

import '../../../domain/entities/playlist.dart';

class ListenerPlaylistService {
  final String baseUrl = Domain.url;
  ListenerPlaylistService();

  Future<List<Playlist>> getPlaylists(String token) async {
    final response = await http.get(Uri.parse('$baseUrl/playlists'), headers: {
      "Cookie": token,
    });

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
        body: jsonEncode({"name": playlistName}));
    // print("inside ervice ${token}");
    // print(response.body);
    if (response.statusCode != 201) {
      throw Exception('Failed to create playlist');
    }
  }

  Future<void> editPlaylist(String id, String name, String token) async {
    final response = await http.patch(Uri.parse('$baseUrl/playlists/$id'),
        headers: {
          "Cookie": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"name": name}));
    if (response.statusCode != 200) {
      throw Exception('Failed to edit playlist');
    }
  }

  Future<void> deletePlaylist(String id, String token) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/playlists/$id'), headers: {
      "Cookie": token,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to delete playlist');
    }
  }
}
