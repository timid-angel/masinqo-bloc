import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/albums.dart';

class ListenerFavoriteAlbumCard extends StatelessWidget {
  const ListenerFavoriteAlbumCard({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      width: deviceWidth * 0.2,
      height: deviceWidth * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 3, color: AppColors.listener3)),
      child: Column(
        children: [
          Container(
            width: deviceWidth * 0.45,
            height: deviceWidth * 0.45,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(album.albumArt),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: 0.42 * deviceWidth,
            child: Text(
              album.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
