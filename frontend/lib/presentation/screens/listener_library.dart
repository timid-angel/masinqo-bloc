import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/temp/models/playlist.dart';
import 'package:masinqo/presentation/widgets/listener_library_playlist.dart';

class ListenerLibrary extends StatelessWidget {
  const ListenerLibrary({
    super.key,
    required this.playlists,
  });

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
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
                      context.pushNamed("listener_new_playlist");
                    },
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.listener2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.2,
                children: playlists
                    .map(
                      (p) => GestureDetector(
                        onTap: () {
                          context.pushNamed("listener_playlist", extra: p);
                        },
                        child: LibraryPlaylistCard(playlist: p),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
