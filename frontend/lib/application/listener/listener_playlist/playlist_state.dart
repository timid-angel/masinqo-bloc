import 'package:masinqo/domain/entities/playlist.dart';

abstract class PlaylistState {}

class EmptyPlaylist extends PlaylistState {}

class LoadedPlaylist extends PlaylistState {
  final List<Playlist> playlists;

  LoadedPlaylist(this.playlists);
}

class ErrorPlaylist extends PlaylistState {
  final String error;

  ErrorPlaylist(this.error);
}
