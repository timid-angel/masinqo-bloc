import 'package:masinqo/core.dart';

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




