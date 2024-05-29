import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_events.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';

import 'package:masinqo/presentation/widgets/listener_home_album.dart';

class ListenerHome extends StatelessWidget {
  const ListenerHome({
    super.key,
  });

  // final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlbumBloc>(context).add(FetchAlbums());
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
                          context.pushNamed("listener_album",
                              extra: state.albums[index]);
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
