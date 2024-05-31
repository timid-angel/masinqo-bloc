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

  Future<void> addSongToPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    final response = await http.post(
      Uri.parse('$baseUrl/playlists/songs/$id'),
      headers: {
        "Cookie": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {"name": name, "album": albumId, "index": index, "filePath": filePath},
      ),
    );
    // print("response ${response.body}");
    if (response.statusCode != 201) {
      throw Exception('Failed to add song to playlist');
    }
  }

  Future<void> deleteSongFromPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    print("inside delete song from playlist");
    final response = await http.delete(
      Uri.parse('$baseUrl/playlists/songs/$id'),
      headers: {
        "Cookie": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {"name": name, "filePath": filePath, "album": albumId, "index": index},
      ),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete song from playlist');
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
