import '../entities/albums.dart';

abstract class FavoriteRepository {
  Future<List<Album>> getFavorites();
}
