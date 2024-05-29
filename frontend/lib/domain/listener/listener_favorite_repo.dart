import '../entities/albums.dart';

abstract class FavoriteRepository {
  Future<List<Album>> getFavorites(String token);
  Future<void> addFavorite(String id, String token);
  Future<void> deleteFavorite(String id, String token);
}
