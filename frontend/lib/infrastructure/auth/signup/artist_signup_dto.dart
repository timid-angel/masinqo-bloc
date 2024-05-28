import 'package:masinqo/domain/entities/artists.dart';

class ArtistSignupDTO {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  ArtistSignupDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Artist toArtist() {
    return Artist(
      name: name,
      email: email,
      password: password,
      albums: [],
      profilePicture: '',
    );
  }
}
