import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import  'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';

class ListenerSignupRepository implements ListenerSignupRepositoryInterface {
  final ListenerSignupDataSource dataSource;

  ListenerSignupRepository({required this.dataSource});

  @override
  Future<bool> signupListener(ListenerSignupDTO listener) async {
    try {
      bool success = await dataSource.signupListener(listener);
      return success;
    } catch (e) {
      return false;
    }
  }
}
