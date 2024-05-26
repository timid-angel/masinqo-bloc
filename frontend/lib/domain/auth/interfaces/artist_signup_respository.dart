import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';

abstract class ArtistSignupRepositoryInterface {
  Future<bool> signupArtist(ArtistSignupDTO artist);
}
