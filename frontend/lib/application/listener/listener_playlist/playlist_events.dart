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

class DeletePlaylists extends PlaylistEvent {
  final String token;
  final String id;
  DeletePlaylists({required this.token, required this.id});
}
