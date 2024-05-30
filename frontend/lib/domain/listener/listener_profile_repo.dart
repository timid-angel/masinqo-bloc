import 'package:masinqo/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile(String token);
  Future<Profile> editProfile(
      String token, String name, String email, String password);
}
