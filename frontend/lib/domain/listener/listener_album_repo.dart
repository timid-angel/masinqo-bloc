import '../entities/albums.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}
