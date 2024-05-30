import 'package:masinqo/core.dart';
import 'package:masinqo/domain/entities/albums.dart';

abstract class ArtistEntityS implements Success {}

class ArtistEntitySuccess extends ArtistEntityS {}

class ArtistGetAlbumsSuccess extends ArtistEntityS {
  final List albums;

  ArtistGetAlbumsSuccess({required this.albums});
}

class ArtistGetSongsSuccess extends ArtistEntityS {
  final List songs;

  ArtistGetSongsSuccess({required this.songs});
}

class GetArtistInformationSuccess extends ArtistEntityS {
  final String name;
  final String email;
  final String profilePicture;
  final List albums;

  GetArtistInformationSuccess({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.albums,
  });
}

class AddAlbumSuccessD {
  final Album album;

  AddAlbumSuccessD({required this.album});
}
