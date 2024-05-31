import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart';

class ListenerPlaylistCollection {
  late List<Playlist> albums;
  // final String token;

  ListenerPlaylistCollection();
  Future<List<Playlist>> getPlaylists(String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }
    final res = await ListenerPlaylistRepository(ListenerPlaylistService())
        .getPlaylists(token);
    return res;
  }

  Future<void> addPlaylist(String playlistName, String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerPlaylistRepository(ListenerPlaylistService())
        .addPlaylist(playlistName, token);
  }

  Future<void> addSongToPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerPlaylistRepository(ListenerPlaylistService())
        .addSongToPlaylist(id, albumId, token, index, name, filePath);
  }

  Future<void> deleteSongFromPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerPlaylistRepository(ListenerPlaylistService())
        .deleteSongFromPlaylist(id, albumId, token, index, name, filePath);
  }

  Future<void> editPlaylist(String id, String name, String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerPlaylistRepository(ListenerPlaylistService())
        .editPlaylist(id, name, token);
  }

  Future<void> deletePlaylist(String id, String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerPlaylistRepository(ListenerPlaylistService())
        .deletePlaylist(id, token);
  }
}
