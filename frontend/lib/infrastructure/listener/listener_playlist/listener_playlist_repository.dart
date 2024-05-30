import 'package:masinqo/domain/listener/listener_playlist_repo.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart';

import '../../../domain/entities/playlist.dart';

class ListenerPlaylistRepository implements PlaylistRepository {
  final ListenerPlaylistService listenerPlaylistService;
  ListenerPlaylistRepository(this.listenerPlaylistService);

  @override
  Future<List<Playlist>> getPlaylists(String token) async {
    return await listenerPlaylistService.getPlaylists(token);
  }

  @override
  Future<void> addPlaylist(String playlistName, String token) async {
    await listenerPlaylistService.addPlaylist(playlistName, token);
  }

  @override
  Future<void> editPlaylist(String id, String name, String token) async {
    await listenerPlaylistService.editPlaylist(id, name, token);
  }

  @override
  Future<void> deletePlaylist(String id, String token) async {
    await listenerPlaylistService.deletePlaylist(id, token);
  }
}

// void main() async {
//   ListenerPlaylistRepository lpr = ListenerPlaylistRepository(
//       ListenerPlaylistService(
//           token:
//               "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTMwN2ZhNTA1YTI2MDBmOTI0ZjJhMyIsInJvbGUiOjIsImlhdCI6MTcxNjczMjM2MCwiZXhwIjoxNzE2ODE4NzYwfQ.yF5YhbRPU_xjwO_JhDfmD1xRAWXaaaN1d4OnFrmnn8Y"));

//   final res = await lpr.getPlaylists();
//   print(res);
//   for (int i = 0; i < res.length; i++) {
//     String s = " ${res[i].name}, ${res[i].owner}}";

//     print(s);
//   }
// }
