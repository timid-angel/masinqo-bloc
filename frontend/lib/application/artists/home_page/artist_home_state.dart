class ArtistHomeState {
  final String name;
  final String email;
  final String profilePicture;
  List albums;
  ArtistHomeState(
      {required this.name,
      required this.email,
      required this.profilePicture,
      required this.albums});
}

class ArtistHomeFailureState extends ArtistHomeState {
  final String errorMessage;
  ArtistHomeFailureState({
    required super.name,
    required super.email,
    required super.profilePicture,
    required super.albums,
    required this.errorMessage,
  });
}

class ArtistHomeSuccessState extends ArtistHomeState {
  ArtistHomeSuccessState(
      {required super.name,
      required super.email,
      required super.profilePicture,
      required super.albums});
}
