import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/listener_library_playlist.dart';

class ListenerLibrary extends StatelessWidget {
  const ListenerLibrary({
    super.key,
    // required this.playlists,
    required this.token,
  });
  final String token;
  // final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlaylistBloc>(context).add(FetchPlaylists(token: token));
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Playlists",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      context.pushNamed("listener_new_playlist", extra: token);
                    },
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.listener2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<PlaylistBloc, PlaylistState>(
                builder: (context, state) {
                  if (state is EmptyPlaylist) {
                    return const Center(child: Text('No playlists available'));
                  } else if (state is LoadedPlaylist) {
                    return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.2,
                      children: state.playlists
                          .map(
                            (p) => GestureDetector(
                              onTap: () {
                                context.pushNamed("listener_playlist",
                                    extra: p);
                              },
                              child: LibraryPlaylistCard(playlist: p),
                            ),
                          )
                          .toList(),
                    );
                  } else if (state is ErrorPlaylist) {
                    return Center(
                        child:
                            Text('Failed to load playlists: ${state.error}'));
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
