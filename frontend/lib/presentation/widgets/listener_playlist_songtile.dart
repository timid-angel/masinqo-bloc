import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/domain/entities/songs.dart';
import 'package:masinqo/infrastructure/core/url.dart';

import '../../temp/audio_manager/listener_audio_manager.dart';

class PlaylistSongTileWidget extends StatelessWidget {
  const PlaylistSongTileWidget({
    super.key,
    required this.song,
    required this.token,
    required this.id,
    required this.index,
    required this.songPath,
    required this.audioManager,
  });

  final Song song;
  final String token;
  final String id;
  final int index;
  final String songPath;
  final AudioManager audioManager;

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
                      image: NetworkImage(song.albumArt.isNotEmpty
                          ? "${Domain.url}/${song.albumArt}"
                          : "${Domain.url}/local/album_art_placeholder.jpg"),
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
                        song.name,
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
                onPressed: () {
                  BlocProvider.of<PlaylistBloc>(context).add(
                    DeleteSongFromPlaylist(
                        albumId: song.albumArt,
                        token: token,
                        filePath: song.filePath,
                        id: id,
                        index: index,
                        name: song.name),
                  );
                })
          ],
        ),
      ),
    );
  }
}
