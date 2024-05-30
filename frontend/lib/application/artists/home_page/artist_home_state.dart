import 'package:equatable/equatable.dart';

class ArtistHomeState extends Equatable {
  final String name;
  final String email;
  final String profilePicture;
  final List albums;
  const ArtistHomeState(
      {required this.name,
      required this.email,
      required this.profilePicture,
      required this.albums});

  @override
  List<Object?> get props => [];
}

class ArtistHomeFailure extends ArtistHomeState {
  final String errorMessage;
  const ArtistHomeFailure({
    required super.name,
    required super.email,
    required super.profilePicture,
    required super.albums,
    required this.errorMessage,
  });
}
