import 'package:masinqo/domain/entities/profile.dart';
import 'package:masinqo/infrastructure/listener/listener_profile/listener_profile_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_profile/listener_profile_service.dart';

class ListenerProfileCollection {
  // final String token;

  ListenerProfileCollection();

  Future<Profile> getProfile(String token) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }
    final res = await ListenerProfileRepository(ListenerProfileService())
        .getProfile(token);
    return res;
  }

  Future<Profile> editProfile(
      String token, String name, String email, String password) async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }
    final res = await ListenerProfileRepository(ListenerProfileService())
        .editProfile(token, name, email, password);
    return res;
  }
}
