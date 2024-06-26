import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
import 'package:masinqo/presentation/widgets/listener_album_songlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import '../../domain/entities/albums.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class AlbumWidget extends StatefulWidget {
  final Album album;
  final String token;
  final FavoriteBloc favoriteBloc;
  final PlaylistBloc playlistBloc;
  final List<Playlist> playlist;
  final ProfileBloc profileBloc;

  const AlbumWidget({
    super.key,
    required this.playlist,
    required this.album,
    required this.token,
    required this.favoriteBloc,
    required this.playlistBloc,
    required this.profileBloc,
  });

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  late AudioManager audioManager;

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager();
  }

  @override
  void dispose() {
    audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: widget.favoriteBloc,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              const ListenerAppbar(),
            ];
          },
          body: Stack(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight,
                decoration: const BoxDecoration(
                    gradient: AppColors.slantedPurpleGradient),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    AlbumArt(
                        deviceWidth: deviceWidth,
                        albumArt: widget.album.albumArt),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 0),
                      child: Column(
                        children: [
                          AlbumHeadlineWidget(
                              album: widget.album, token: widget.token),
                          const Divider(height: 30, thickness: 2),
                          AlbumTracksWidget(
                            album: widget.album,
                            onAdd: () {},
                            audioManager: audioManager,
                            playlists: widget.playlist,
                            token: widget.token,
                            playlistBloc: widget.playlistBloc,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawer: ListenerDrawer(
          token: widget.token,
          profileBloc: widget.profileBloc,
        ),
      ),
    );
  }
}


// class PlaylistNavigationArgument {
//   final String token;
//   final Playlist playlist;
//   final PlaylistBloc playlistBloc;

//   PlaylistNavigationArgument(
//       {required this.token,
//       required this.playlist,
//       required this.playlistBloc});
// }