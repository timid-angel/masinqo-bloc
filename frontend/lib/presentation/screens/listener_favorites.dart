import 'package:flutter/material.dart';
import 'package:masinqo/models/albums.dart';
import 'package:masinqo/presentation/widgets/listener_favorite_album.dart';

class ListenerFavorites extends StatelessWidget {
  const ListenerFavorites({
    super.key,
    required this.favorites,
  });

  final List<Album> favorites;

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
              child: Text(
                "Favorites",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.68,
                children: favorites
                    .map(
                      (a) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/listener/album",
                            arguments: a,
                          );
                        },
                        child: ListenerFavoriteAlbumCard(album: a),
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
