import 'package:flutter/material.dart';
import 'package:masinqo/models/songs.dart';
import '../../audio_manager/listener_audio_manager.dart';

class PlaylistSongTileWidget extends StatelessWidget {
  const PlaylistSongTileWidget({
    Key? key,
   
    required this. onDelete,
    required this.song,
    required this.audioManager,
  }) : super(key: key);

  final Song song;
  final AudioManager audioManager; 

  final Function() onDelete;
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
             IconButton(
            icon: const Icon(Icons.remove_circle_outline,
                color: Color.fromARGB(255, 237, 86, 84)),
            onPressed: onDelete,
          )
          ],
        ),
      ),
    );
  }
}
