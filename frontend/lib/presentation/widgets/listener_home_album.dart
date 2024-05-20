import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/albums.dart';

class ListenerHomeAlbumCard extends StatelessWidget {
  const ListenerHomeAlbumCard({
    super.key,
    required this.album,
  });

  final Album album;

  static const TextStyle pinkColored =
      TextStyle(color: AppColors.listener2, fontSize: 15);
  static const TextStyle whiteColored = TextStyle(color: AppColors.fontColor);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(width: 3.5, color: AppColors.listener3),
        borderRadius: BorderRadius.circular(10),
      ),
      width: deviceWidth * 0.75,
      height: deviceWidth * 0.5,
      child: Row(
        children: [
          Container(
            width: deviceWidth * 0.38,
            height: deviceWidth * 0.5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(album.albumArt),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
            width: deviceWidth * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Artist: ",
                      style: pinkColored,
                      children: [
                        TextSpan(
                          text: album.artist.name,
                          style: whiteColored,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Tracks: ",
                      style: pinkColored,
                      children: [
                        TextSpan(
                          text: (album.songs.length).toString(),
                          style: whiteColored,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Genre: ",
                      style: pinkColored,
                      children: [
                        TextSpan(
                          text: album.genre,
                          style: whiteColored,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Release Date: ",
                      style: pinkColored,
                      children: [
                        TextSpan(
                          text:
                              album.date.toLocal().toString().substring(0, 10),
                          style: whiteColored,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
