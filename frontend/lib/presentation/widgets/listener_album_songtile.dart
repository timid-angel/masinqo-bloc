import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/entities/songs.dart';
import 'package:masinqo/infrastructure/core/url.dart';

import '../../temp/audio_manager/listener_audio_manager.dart';

class AlbumSongTileWidget extends StatelessWidget {
  const AlbumSongTileWidget({
    super.key,
    required this.onAdd,
    required this.song,
    required this.audioManager,
    required this.playlists,
    required this.token,
    required this.index,
    required this.albumId,
    required this.name,
    required this.filePath,
  });

  final Song song;
  final String filePath;
  final String name;
  final List<Playlist> playlists;
  final String token;
  final int index;
  final String albumId;
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
                      image: NetworkImage(song.albumArt.isNotEmpty
                          ? "${Domain.url}/${song.albumArt}"
                          : "${Domain.url}/local / album_art_placeholder.jpg"),
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
                        song.name, //its showing the song name twice here
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
            PopupMenuButton<Playlist>(
              icon: const Icon(Icons.add_circle),
              itemBuilder: (context) {
                return playlists.map((playlist) {
                  return PopupMenuItem<Playlist>(
                    value: playlist,
                    child: Text(playlist.name),
                  );
                }).toList();
              },
              onSelected: (playlist) {
                final playlistBloc = BlocProvider.of<PlaylistBloc>(context);
                playlistBloc.add(
                  AddSongToPlaylist(
                    id: playlist.id ?? "",
                    albumId: albumId,
                    token: token,
                    index: index,
                    name: name,
                    filePath: filePath,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
