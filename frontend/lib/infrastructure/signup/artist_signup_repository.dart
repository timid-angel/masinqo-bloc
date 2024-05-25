import 'package:masinqo/domain/signup/artist.dart';
import 'package:masinqo/infrastructure/signup/artist_signup_datasource.dart';

class ArtistSignupRepository {
  final ArtistSignupDataSource dataSource;

  ArtistSignupRepository({required this.dataSource});

  Future<bool> signupArtist(Artist artist, String confirmPassword) async {
    try {
      bool success = await dataSource.signupArtist(artist, confirmPassword);
      return success;
    } catch (e) {
      print('Error signing up artist: $e');
      return false;
    }
  }
}
