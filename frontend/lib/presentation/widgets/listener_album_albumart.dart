import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({
    super.key,
    required this.deviceWidth,
    required this.albumArt,
  });

  final double deviceWidth;
  final String albumArt;

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
          image: AssetImage(albumArt),
        ),
      ),
    );
  }
}
