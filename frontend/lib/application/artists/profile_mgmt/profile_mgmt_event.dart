import 'package:equatable/equatable.dart';

abstract class UpdateArtistEvent extends Equatable {
  const UpdateArtistEvent();

  @override
  List<Object?> get props => [];
}

class UpdateArtistInformation extends UpdateArtistEvent {
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
  List<Object?> get props =>
      [name, email, password, profilePictureFilePath];
}
