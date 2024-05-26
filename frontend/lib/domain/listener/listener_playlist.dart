import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart';

class ListenerPlaylistCollection {
  late List<Playlist> albums;
  final String token;

  ListenerPlaylistCollection({required this.token});
  Future<List<Playlist>> getPlaylists() async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    final res =
        await ListenerPlaylistRepository(ListenerPlaylistService(token: token))
            .getPlaylists();
    return res;
  }
}
