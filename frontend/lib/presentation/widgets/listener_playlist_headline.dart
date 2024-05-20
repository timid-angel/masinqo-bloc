import 'package:flutter/material.dart';
import 'package:masinqo/models/playlist.dart';

class PlaylistHeadlineWidget extends StatelessWidget {
  const PlaylistHeadlineWidget({super.key, required this.playlist});

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: deviceWidth * 0.8,
              child: Text(
                playlist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              "${playlist.songs.length} tracks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
