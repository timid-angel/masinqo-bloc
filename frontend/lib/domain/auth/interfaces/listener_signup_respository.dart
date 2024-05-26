import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

abstract class ListenerSignupRepositoryInterface {
  Future<bool> signupListener(ListenerSignupDTO listener);
}
