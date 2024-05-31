import '../entities/playlist.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> getPlaylists(String token);
  Future<void> addPlaylist(String playlistName, String token);
  Future<void> editPlaylist(String id, String name, String token);
  Future<void> deletePlaylist(String id, String token);
  Future<void> addSongToPlaylist(String id, String albumId, String token,
      int index, String name, String filePath);

  Future<void> deleteSongFromPlaylist(String id, String albumId, String token,
      int index, String name, String filePath);
}
