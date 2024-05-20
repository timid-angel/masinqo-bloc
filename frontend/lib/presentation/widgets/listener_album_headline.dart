import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/albums.dart';

class AlbumHeadlineWidget extends StatefulWidget {
  const AlbumHeadlineWidget({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  State<AlbumHeadlineWidget> createState() => _AlbumHeadlineWidgetState();
}

class _AlbumHeadlineWidgetState extends State<AlbumHeadlineWidget> {
  bool liked = true;

  void _handleFavoriteTap() {
    setState(() {
      liked = !liked;
    });

    if (!liked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Album removed from favorites'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.listener3,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Album added to favorites'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.listener3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    IconData icon = liked ? Icons.favorite : Icons.favorite_border_outlined;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: deviceWidth * 0.7,
              child: Text(
                widget.album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              "${widget.album.songs.length} tracks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        GestureDetector(
          onTap: _handleFavoriteTap,
          child: Icon(
            icon,
            color: AppColors.listener2,
            size: 35,
          ),
        ),
      ],
    );
  }
}
