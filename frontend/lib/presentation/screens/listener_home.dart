import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_events.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_events.dart';

import 'package:masinqo/domain/entities/albums.dart';

import 'package:masinqo/presentation/widgets/listener_home_album.dart';

class ListenerHome extends StatelessWidget {
  const ListenerHome({
    super.key,
    required this.token,
  });
  final String token;
  // final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlbumBloc>(context).add(FetchAlbums());
    BlocProvider.of<FavoriteBloc>(context).add(FetchFavorites(token: token));

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
                            token: token,
                            album: state.albums[index],
                            favoriteBloc:
                                BlocProvider.of<FavoriteBloc>(context),
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

  AlbumNavigationArgument({
    required this.token,
    required this.album,
    required this.favoriteBloc,
  });
}
