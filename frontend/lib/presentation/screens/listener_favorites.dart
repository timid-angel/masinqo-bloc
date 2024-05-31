import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_events.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/widgets/listener_favorite_album.dart';

class ListenerFavorites extends StatefulWidget {
  const ListenerFavorites({
    super.key,
    required this.token,
    required this.profileBloc,
    // required this.favorites,
  });
  final String token;
  final ProfileBloc profileBloc;

  @override
  State<ListenerFavorites> createState() => _ListenerFavoritesState();
}

class _ListenerFavoritesState extends State<ListenerFavorites> {
  // final List<Album> favorites;
  List<Playlist> playlists = [];

  @override
  void initState() {
    super.initState();
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
    BlocProvider.of<FavoriteBloc>(context)
        .add(FetchFavorites(token: widget.token));
    BlocProvider.of<PlaylistBloc>(context)
        .add(FetchPlaylists(token: widget.token));
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Favorites",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is EmptyFavorite) {
                    return const Center(child: Text('No Favorites available'));
                  } else if (state is LoadedFavorite) {
                    return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.68,
                      children: state.favorites
                          .map(
                            (a) => GestureDetector(
                              onTap: () {
                                final arguments = AlbumNavigationArgument(
                                  token: widget.token,
                                  album: a,
                                  favoriteBloc:
                                      BlocProvider.of<FavoriteBloc>(context),
                                  playlistBloc:
                                      BlocProvider.of<PlaylistBloc>(context),
                                  playlists: playlists,
                                  profileBloc: widget.profileBloc,
                                );
                                context.pushNamed("listener_album",
                                    extra: arguments);
                              },
                              child: ListenerFavoriteAlbumCard(album: a),
                            ),
                          )
                          .toList(),
                    );
                  } else if (state is ErrorFavorite) {
                    return Center(
                        child:
                            Text('Failed to load Favorites: ${state.error}'));
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
