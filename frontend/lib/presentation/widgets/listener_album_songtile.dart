
import 'package:flutter/material.dart';
import 'package:masinqo/models/songs.dart';
import '../../audio_manager/listener_audio_manager.dart';

class AlbumSongTileWidget extends StatelessWidget {
  const AlbumSongTileWidget({
    Key? key,
    required this.onAdd,
    required this.song,
    required this.audioManager,
  }) : super(key: key);

  final Song song;
  final AudioManager audioManager;
  final Function() onAdd;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        audioManager.stop();
        audioManager.play(song.filePath); 
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: deviceWidth * 0.14,
                  height: deviceWidth * 0.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(song.album.albumArt),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.5,
                      child: Text(
                        song.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.52,
                      child: Text(
                        song.album.artist.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
            PopupMenuButton(
              icon: const Icon(Icons.add_circle),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(child: Text('Playlist 1')),
                  const PopupMenuItem(child: Text('Playlist 2')),
                  const PopupMenuItem(child: Text('Playlist 3')),
                  const PopupMenuItem(child: Text('Playlist 4')),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
