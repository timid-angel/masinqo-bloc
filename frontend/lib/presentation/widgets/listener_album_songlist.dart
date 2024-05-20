import 'package:flutter/material.dart';
import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/songs.dart';
import 'package:masinqo/presentation/widgets/listener_album_songtile.dart';
import '../../audio_manager/listener_audio_manager.dart';

class AlbumTracksWidget extends StatelessWidget {
  const AlbumTracksWidget({
    Key? key,
    required this.album,
    required this.onAdd,
    required this.audioManager, 
  }) : super(key: key);

  final Album album;
  final Function() onAdd;
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
          itemCount: album.songs.length,
          itemBuilder: (context, idx) {
            Song song = album.songs[idx];
            return AlbumSongTileWidget(song: song, onAdd: onAdd, audioManager: audioManager); 
          },
        ),
      ],
    );
  }
}
