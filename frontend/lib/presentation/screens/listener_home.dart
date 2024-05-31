import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_events.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';

import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/entities/playlist.dart';

import 'package:masinqo/presentation/widgets/listener_home_album.dart';

class ListenerHome extends StatefulWidget {
  const ListenerHome({
    super.key,
    required this.token,
    required this.profileBloc,
  });
  final String token;
  final ProfileBloc profileBloc;

  @override
  _ListenerHomeState createState() => _ListenerHomeState();
}

class _ListenerHomeState extends State<ListenerHome> {
  List<Playlist> playlists = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AlbumBloc>(context).add(FetchAlbums());
    BlocProvider.of<FavoriteBloc>(context)
        .add(FetchFavorites(token: widget.token));
    BlocProvider.of<PlaylistBloc>(context)
        .add(FetchPlaylists(token: widget.token));

    BlocProvider.of<PlaylistBloc>(context).stream.listen((state) {
      if (state is LoadedPlaylist) {
        setState(() {
          playlists = state.playlists;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlbumBloc>(context).add(FetchAlbums());
    BlocProvider.of<PlaylistBloc>(context)
        .add(FetchPlaylists(token: widget.token));
    BlocProvider.of<FavoriteBloc>(context)
        .add(FetchFavorites(token: widget.token));

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Albums",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: BlocBuilder<AlbumBloc, AlbumState>(
                builder: (context, state) {
                  if (state is EmptyAlbum) {
                    return const Center(child: Text('No Albums available'));
                  } else if (state is LoadedAlbum) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.albums.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          final arguments = AlbumNavigationArgument(
                            token: widget.token,
                            album: state.albums[index],
                            favoriteBloc:
                                BlocProvider.of<FavoriteBloc>(context),
                            playlistBloc:
                                BlocProvider.of<PlaylistBloc>(context),
                            playlists: playlists,
                            profileBloc: widget.profileBloc,
                          );

                          context.pushNamed("listener_album", extra: arguments);
                        },
                        child: ListenerHomeAlbumCard(
                          album: state.albums[index],
                        ),
                      ),
                    );
                  } else if (state is ErrorAlbum) {
                    return Center(
                        child: Text('Failed to load Album: ${state.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumNavigationArgument {
  final String token;
  final Album album;
  final FavoriteBloc favoriteBloc;
  final PlaylistBloc playlistBloc;
  final List<Playlist> playlists;
  final ProfileBloc profileBloc;

  AlbumNavigationArgument({
    required this.playlists,
    required this.token,
    required this.album,
    required this.favoriteBloc,
    required this.playlistBloc,
    required this.profileBloc,
  });
}
