import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/entities/songs.dart';

import 'package:masinqo/presentation/widgets/listener_album_songtile.dart';
import '../../domain/entities/albums.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class AlbumTracksWidget extends StatelessWidget {
  const AlbumTracksWidget(
      {super.key,
      required this.album,
      required this.onAdd,
      required this.audioManager,
      required this.playlists,
      required this.token,
      required this.playlistBloc});

  final Album album;
  final Function() onAdd;
  final AudioManager audioManager;
  final List<Playlist> playlists;
  final PlaylistBloc playlistBloc;
  final String token;

  @override
  Widget build(BuildContext context) {
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
          itemCount: album.songs.length,
          itemBuilder: (context, idx) {
            Song song = album.songs[idx];
            return BlocProvider.value(
              value: playlistBloc,
              child: AlbumSongTileWidget(
                song: song,
                onAdd: onAdd,
                audioManager: audioManager,
                index: idx,
                albumId: album.id,
                playlists: playlists,
                token: token,
                name: song.name,
                filePath: song.filePath,
              ),
            );
          },
        ),
      ],
    );
  }
}
