import 'package:masinqo/domain/auth/interfaces/listener_signup_respository.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class ListenerSignupRepository implements ListenerSignupRepositoryInterface {
  final ListenerSignupDataSource dataSource;

  ListenerSignupRepository({required this.dataSource});

  Future<bool> signupListener(ListenerSignupDTO listener) async {
    try {
      bool success = await dataSource.signupListener(listener);
      return success;
    } catch (e) {
      return false;
    }
  }
}
