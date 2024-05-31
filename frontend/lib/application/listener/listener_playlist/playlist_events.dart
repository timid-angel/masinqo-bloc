abstract class PlaylistEvent {}

class FetchPlaylists extends PlaylistEvent {
  final String token;
  FetchPlaylists({required this.token});
}

class CreatePlaylists extends PlaylistEvent {
  final String token;
  final String name;
  CreatePlaylists({required this.token, required this.name});
}

class EditPlaylists extends PlaylistEvent {
  final String token;
  final String id;
  final String name;
  EditPlaylists({required this.token, required this.id, required this.name});
}

class AddSongToPlaylist extends PlaylistEvent {
  final String token;
  final String id;
  final String albumId;
  final int index;
  final String name;
  final String filePath;
  AddSongToPlaylist(
      {required this.token,
      required this.filePath,
      required this.id,
      required this.albumId,
      required this.index,
      required this.name});
}

class DeletePlaylists extends PlaylistEvent {
  final String token;
  final String id;
  DeletePlaylists({required this.token, required this.id});
}

class DeleteSongFromPlaylist extends PlaylistEvent {
  final String token;
  final String id;
  final String albumId;
  final int index;
  final String name;
  final String filePath;

  DeleteSongFromPlaylist(
      {required this.token,
      required this.filePath,
      required this.id,
      required this.albumId,
      required this.index,
      required this.name});
}
