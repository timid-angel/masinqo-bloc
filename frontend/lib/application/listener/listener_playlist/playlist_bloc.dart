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
      try {
        await playlistRepository.addPlaylist(event.name, event.token);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });

    on<EditPlaylists>((event, emit) async {
      try {
        await playlistRepository.editPlaylist(
            event.id, event.name, event.token);
        final playlists = await playlistRepository.getPlaylists(event.token);
        emit(LoadedPlaylist(playlists));
      } catch (e) {
        emit(ErrorPlaylist(e.toString()));
      }
    });
  }
}
