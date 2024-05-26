import '../entities/playlist.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> getPlaylists();
}
