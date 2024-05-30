import 'package:masinqo/core.dart';
import 'package:masinqo/domain/entities/albums.dart';

abstract class ArtistsSuccessImpl implements Success {}

class ArtistsSuccess extends ArtistsSuccessImpl {}

class GetAlbumsSuccess extends ArtistsSuccessImpl {
  final List albums;

  GetAlbumsSuccess({required this.albums});
}

class GetSongsSuccess extends ArtistsSuccessImpl {
  final List songs;

  GetSongsSuccess({required this.songs});
}

class AddAlbumSuccess extends ArtistsSuccessImpl {
  final Album album;

  AddAlbumSuccess({required this.album});
}
