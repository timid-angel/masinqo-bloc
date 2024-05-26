abstract class ArtistEntityF {}

class ArtistEntityFailure extends ArtistEntityF {
  final String message;

  ArtistEntityFailure({required this.message});
}
