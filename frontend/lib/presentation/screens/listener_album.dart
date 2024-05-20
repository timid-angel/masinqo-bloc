import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/albums.dart';
import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
import 'package:masinqo/presentation/widgets/listener_album_songlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import '../../audio_manager/listener_audio_manager.dart'; 

class AlbumWidget extends StatefulWidget {
  const AlbumWidget({Key? key}) : super(key: key);

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  late Album album;
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
    album = ModalRoute.of(context)!.settings.arguments as Album;

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
                  AlbumArt(deviceWidth: deviceWidth, albumArt: album.albumArt),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Column(
                      children: [
                        AlbumHeadlineWidget(album: album),
                        const Divider(height: 30, thickness: 2),
                      
                        AlbumTracksWidget(album: album, onAdd: () {}, audioManager: audioManager),
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
