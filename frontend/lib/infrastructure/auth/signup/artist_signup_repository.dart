import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import  'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';

class ArtistSignupRepository implements ArtistSignupRepositoryInterface {
  final ArtistSignupDataSource dataSource;

  ArtistSignupRepository({required this.dataSource});

  @override
  Future<bool> signupArtist(ArtistSignupDTO artist) async {
    try {
      bool success = await dataSource.signupArtist(artist);
      return success;
    } catch (e) {
      return false;
    }
  }
}
