import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_buttons.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_headline.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_songlist.dart';
import '../../audio_manager/listener_audio_manager.dart';

class PlaylistWidget extends StatefulWidget {
  const PlaylistWidget({Key? key}) : super(key: key);

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  late Playlist playlist;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    playlist = ModalRoute.of(context)!.settings.arguments as Playlist;

    final AudioManager audioManager = AudioManager();

    return Scaffold(
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
                  PlaylistAlbumArt(
                      deviceWidth: deviceWidth, playlist: playlist),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Column(
                      children: [
                        PlaylistHeadlineWidget(playlist: playlist),
                        PlaylistButtonsWidget(
                          editController: () {},
                          deleteController: () {},
                          playlistName: playlist.name,
                        ),
                        const Divider(height: 30, thickness: 2),
                        PlaylistTracksWidget(
                          playlist: playlist,
                          onDelete: () {},
                          audioManager: audioManager,
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
      endDrawer: const ListenerDrawer(),
    );
  }
}
