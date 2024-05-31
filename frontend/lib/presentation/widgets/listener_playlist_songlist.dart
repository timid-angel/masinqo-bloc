import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/entities/songs.dart';

import '../widgets/listener_playlist_songtile.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class PlaylistTracksWidget extends StatelessWidget {
  const PlaylistTracksWidget({
    super.key,
    required this.playlist,
    required this.bloc,
    required this.token,
    required this.audioManager,
  });
  final String token;
  final Playlist playlist;
  final PlaylistBloc bloc;

  final AudioManager audioManager;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        Playlist currentPlaylist = playlist;
        if (state is LoadedPlaylist) {
          currentPlaylist = state.playlists.firstWhere(
            (p) => p.id == playlist.id,
            orElse: () => playlist,
          );
        }

        return Column(
          children: [
            Text(
              'Tracks',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: currentPlaylist.songs.length,
              itemBuilder: (context, idx) {
                Song song = currentPlaylist.songs[idx];
                return BlocProvider.value(
                  value: BlocProvider.of<PlaylistBloc>(context),
                  child: PlaylistSongTileWidget(
                    song: song,
                    token: token,
                    id: currentPlaylist.id ?? "",
                    index: idx,
                    songPath: song.filePath,
                    audioManager: audioManager,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
