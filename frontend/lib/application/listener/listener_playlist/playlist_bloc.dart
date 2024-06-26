import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final ListenerPlaylistCollection playlistRepository;

  PlaylistBloc({required this.playlistRepository}) : super(EmptyPlaylist()) {
    on<FetchPlaylists>((event, emit) async {
      try {
        final playlists = await playlistRepository.getPlaylists(event.token);
        if (playlists.isEmpty) {
          emit(EmptyPlaylist());
        } else {
          emit(LoadedPlaylist(playlists));
        }
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<CreatePlaylists>((event, emit) async {
      // print("event name is ${event.name}");
      try {
        await playlistRepository.addPlaylist(event.name, event.token);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<EditPlaylists>((event, emit) async {
      // print("event name is ${event.name}");
      // print(event.id);
      try {
        await playlistRepository.editPlaylist(
            event.id, event.name, event.token);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<DeletePlaylists>((event, emit) async {
      try {
        await playlistRepository.deletePlaylist(event.id, event.token);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<AddSongToPlaylist>((event, emit) async {
      try {
        await playlistRepository.addSongToPlaylist(event.id, event.albumId,
            event.token, event.index, event.name, event.filePath);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<DeleteSongFromPlaylist>((event, emit) async {
      try {
        await playlistRepository.deleteSongFromPlaylist(event.id, event.albumId,
            event.token, event.index, event.name, event.filePath);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });
  }
}
