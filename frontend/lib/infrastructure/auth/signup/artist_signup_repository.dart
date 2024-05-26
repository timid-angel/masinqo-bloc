import 'package:masinqo/domain/auth/interfaces/artist_signup_respository.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';

class ArtistSignupRepository implements ArtistSignupRepositoryInterface {
  ArtistSignupRepository();

  Future<bool> signupArtist(ArtistSignupDTO artist) async {
    try {
      bool success = await ArtistSignupDataSource().signupArtist(artist);
      return success;
    } catch (e) {
      return false;
    }
  }
}
