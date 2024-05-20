import 'package:flutter/material.dart';
import '../../data/artist_data.dart';
import '../../audio_manager/artist_audio_manager.dart';


class SongCard extends StatelessWidget {
  final int songNumber;
  final String songName;
  final String artistName;
  final String imagePath;
  final String songFilePath;
  final AudioManager audioManager; 

  const SongCard({
    super.key,
    required this.songNumber,
    required this.songName,
    required this.artistName,
    required this.imagePath,
    required this.songFilePath,
    required this.audioManager,
  });

  @override
  Widget build(BuildContext context) {
    final String lastArtistName = artistData.last.name;

    return GestureDetector(
      onTap: () {
         audioManager.play(songFilePath);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                '$songNumber',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    lastArtistName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 189, 188, 188),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
