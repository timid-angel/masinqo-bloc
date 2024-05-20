import 'package:flutter/material.dart';
import 'package:masinqo/models/playlist.dart';

class LibraryPlaylistCard extends StatelessWidget {
  const LibraryPlaylistCard({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    // double deviceHeight = MediaQuery.of(context).size.height;

    Widget banner;
    String firstArt = "assets/images/black.png";
    String secondArt = "assets/images/black.png";

    if (playlist.songs.length >= 2) {
      firstArt = playlist.songs[0].album.albumArt;
      secondArt = playlist.songs[1].album.albumArt;
      for (int i = 0; i < playlist.songs.length; i++) {
        if (playlist.songs[i].album.albumArt != firstArt) {
          secondArt = playlist.songs[i].album.albumArt;
          break;
        }
      }
    } else if (playlist.songs.length == 1) {
      firstArt = playlist.songs[0].album.albumArt;
    }

    banner = Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(firstArt),
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(secondArt),
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 49, 13, 55),
            Color.fromARGB(255, 23, 8, 40),
            Color.fromARGB(126, 34, 10, 51)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: banner,
            ),
          ),
          Expanded(
            child: Text(
              playlist.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
