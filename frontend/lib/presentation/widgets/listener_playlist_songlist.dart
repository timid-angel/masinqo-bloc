import 'package:flutter/material.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/songs.dart';
import '../widgets/listener_playlist_songtile.dart';
import '../../audio_manager/listener_audio_manager.dart';

class PlaylistTracksWidget extends StatelessWidget {
  const PlaylistTracksWidget({
    Key? key,
    required this.playlist,
   
    required this.onDelete,
    required this.audioManager, 
  }) : super(key: key);

  final Playlist playlist;
  final Function() onDelete;
 
  final AudioManager audioManager; 

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
          itemCount: playlist.songs.length,
          itemBuilder: (context, idx) {
            Song song = playlist.songs[idx];
            return PlaylistSongTileWidget(
              song: song,
              onDelete: onDelete,
          
              audioManager: audioManager,
            );
          },
        ),
      ],
    );
  }
}
