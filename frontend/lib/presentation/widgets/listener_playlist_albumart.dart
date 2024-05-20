import 'package:flutter/material.dart';
import 'package:masinqo/models/playlist.dart';

class PlaylistAlbumArt extends StatelessWidget {
  const PlaylistAlbumArt({
    super.key,
    required this.deviceWidth,
    required this.playlist,
  });

  final double deviceWidth;
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7 * deviceWidth,
      width: 0.7 * deviceWidth,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(playlist.songs[1].album.albumArt),
        ),
      ),
    );
  }
}
