abstract class ArtistEntityS {}

class ArtistEntitySuccess extends ArtistEntityS {}

class ArtistGetAlbumsSuccess extends ArtistEntityS {
  final List albums;

  ArtistGetAlbumsSuccess({required this.albums});
}

class ArtistGetSongsSuccess extends ArtistEntityS {
  final List songs;

  ArtistGetSongsSuccess({required this.songs});
}
