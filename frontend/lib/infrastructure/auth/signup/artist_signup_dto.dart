import 'package:masinqo/domain/entities/artists.dart';

class ArtistSignupDTO {
  final String name;
  final String email;
  final String password;

  ArtistSignupDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  Artist toArtist() {
    return Artist(
      name: name,
      email: email,
      password: password, albums: [], profilePicture: '',
    );
  }
}