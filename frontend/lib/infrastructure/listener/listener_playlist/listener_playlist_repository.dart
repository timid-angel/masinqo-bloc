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

  @override
  Future<void> addSongToPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    await listenerPlaylistService.addSongToPlaylist(
        id, albumId, token, index, name, filePath);
  }

  @override
  Future<void> deleteSongFromPlaylist(String id, String albumId, String token,
      int index, String name, String filePath) async {
    await listenerPlaylistService.deleteSongFromPlaylist(
        id, albumId, token, index, name, filePath);
  }
}

// void main() async {
//   ListenerPlaylistRepository lpr =
//       ListenerPlaylistRepository(ListenerPlaylistService());

//   final res = await lpr.getPlaylists(
//       "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTllZDkyZjBjYzQyMzMyZDJlZmIwYSIsInJvbGUiOjIsImlhdCI6MTcxNzE2OTU1OSwiZXhwIjoxNzE3MjU1OTU5fQ.nUigp79uxWq5_FWiwzcQPMPCaPpmQYaY80kTGCkCUog");
//   print(res);
//   for (int i = 0; i < res.length; i++) {
//     String s = " ${res[i].name}, ${res[i].owner}}";

//     print(s);
//   }

//   await lpr.addSongToPlaylist(
//       "6659f017f0cc42332d2efb19",
//       "6657c5250863c8f01c3b0c13",
//       "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTllZDkyZjBjYzQyMzMyZDJlZmIwYSIsInJvbGUiOjIsImlhdCI6MTcxNzE2OTU1OSwiZXhwIjoxNzE3MjU1OTU5fQ.nUigp79uxWq5_FWiwzcQPMPCaPpmQYaY80kTGCkCUog",
//       2);

//   final ress = await lpr.getPlaylists(
//       "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTllZDkyZjBjYzQyMzMyZDJlZmIwYSIsInJvbGUiOjIsImlhdCI6MTcxNzE2OTU1OSwiZXhwIjoxNzE3MjU1OTU5fQ.nUigp79uxWq5_FWiwzcQPMPCaPpmQYaY80kTGCkCUog");
//   print(ress);
//   for (int i = 0; i < ress.length; i++) {
//     String s = " ${ress[i].name}, ${ress[i].owner}}";

//     print(s);
//   }
// }
