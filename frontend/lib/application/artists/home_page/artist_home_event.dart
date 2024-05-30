import 'package:equatable/equatable.dart';

abstract class ArtistHomeEvent extends Equatable {
  const ArtistHomeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateArtistInformation extends ArtistHomeEvent {
  final String name;
  final String email;
  final String password;
  final String profilePictureFilePath;

  const UpdateArtistInformation({
    required this.name,
    required this.email,
    required this.password,
    required this.profilePictureFilePath,
  });

  @override
  List<Object?> get props => [name, email, password, profilePictureFilePath];
}

class GetArtistInformation extends ArtistHomeEvent {}
