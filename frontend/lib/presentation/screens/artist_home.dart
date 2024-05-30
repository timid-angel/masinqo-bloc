import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_state.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:masinqo/presentation/widgets/artist_app_bar.dart';
import 'package:masinqo/presentation/widgets/artist_create_album_modal.dart';
import 'package:masinqo/presentation/widgets/artist_drawer.dart';
import 'package:masinqo/presentation/widgets/artist_profile_section.dart';

class ArtistHomePage extends StatefulWidget {
  final String token;

  const ArtistHomePage({super.key, required this.token});

  @override
  ArtistHomePageState createState() => ArtistHomePageState();
}

class ArtistHomePageState extends State<ArtistHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ArtistHomeBloc artistHomeBloc;

  @override
  void initState() {
    super.initState();
    artistHomeBloc = ArtistHomeBloc(token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => artistHomeBloc,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
        backgroundColor: Colors.black,
        endDrawer: BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
            builder: (context, state) => ArtistDrawer(
                  artistHomeBloc: artistHomeBloc,
                )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                  builder: (context, state) {
                return ArtistProfileSection(
                  artistName: state.name,
                  profilePicture: state.profilePicture.isNotEmpty
                      ? state.profilePicture
                      : "local/artist_placeholder.jpg",
                );
              }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color(0xFF39DCF3),
                          size: 30,
                        ),
                        onPressed: () {
                          showModal(context,
                              BlocProvider.of<ArtistHomeBloc>(context));
                        },
                      );
                    }),
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
              BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                builder: (context, state) {
                  final List<Widget> arr = [];
                  for (int i = 0; i < state.albums.length; i++) {
                    if (i >= state.albums.length) {
                      break;
                    }
                    final album = state.albums[i];
                    final List<Song> songs = [];
                    for (final song in album["songs"]) {
                      final Song currSong =
                          Song(filePath: song["filePath"], name: song["name"]);
                      songs.add(currSong);
                    }
                    arr.add(
                      AlbumCard(
                        album: AlbumState(
                            title: album["title"],
                            description: album["description"],
                            genre: album["genre"],
                            date: DateTime.parse(album["date"]),
                            albumArt: album["albumArtPath"] ??
                                "local/album_art_placeholder.jpg",
                            artist: state.name,
                            songs: songs,
                            error: '',
                            albumId: album["_id"]),
                        token: widget.token,
                        artistHomeBloc:
                            BlocProvider.of<ArtistHomeBloc>(context),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: arr,
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void showModal(BuildContext context, ArtistHomeBloc artistHomeBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateAlbumModal(
          artistHomeBloc: artistHomeBloc,
          token: widget.token,
        );
      },
    );
  }
}
