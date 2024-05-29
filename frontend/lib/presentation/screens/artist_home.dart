import 'package:flutter/material.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:masinqo/presentation/widgets/artist_app_bar.dart';
import 'package:masinqo/presentation/widgets/artist_create_album_modal.dart';
import 'package:masinqo/presentation/widgets/artist_drawer.dart';
import 'package:masinqo/presentation/widgets/artist_profile_section.dart';
import 'package:masinqo/temp/models/albums.dart';

class ArtistHomePage extends StatefulWidget {
  final List<Album> albumData;
  final String token;

  const ArtistHomePage({super.key, required this.albumData, required this.token});

  @override
  ArtistHomePageState createState() => ArtistHomePageState();
}

class ArtistHomePageState extends State<ArtistHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
      backgroundColor: Colors.black,
      endDrawer: const ArtistDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ArtistProfileSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF39DCF3),
                      size: 30,
                    ),
                    onPressed: () {
                      showModal(context);
                    },
                  ),
                  const Text(
                    'Create Album',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            for (final album in widget.albumData) AlbumCard(album: album),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(widget.token);
        return CreateAlbumModal();
        
      },
    );
  }
}
