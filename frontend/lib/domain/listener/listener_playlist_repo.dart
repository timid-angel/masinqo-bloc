import '../entities/playlist.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> getPlaylists(String token);
  Future<void> addPlaylist(String playlistName, String token);
  Future<void> editPlaylist(String id, String name, String token);
}
