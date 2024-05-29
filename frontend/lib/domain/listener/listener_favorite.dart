import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_service.dart';

class ListenerFavCollection {
  late List<Album> albums;
  // final String token;

  ListenerFavCollection();
  Future<List<Album>> getFavorites(String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    final res =
        await ListenerFavRepository(ListenerFavService()).getFavorites(token);
    return res;
  }

  Future<void> addFavorite(String id, String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerFavRepository(ListenerFavService()).addFavorite(id, token);
  }

  Future<void> deleteFavorite(String id, String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    await ListenerFavRepository(ListenerFavService()).deleteFavorite(id, token);
  }
}
