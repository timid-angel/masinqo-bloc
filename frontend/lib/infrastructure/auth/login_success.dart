import 'package:masinqo/core.dart';

class LoginRequestSuccess implements Success {
  final String token;
  LoginRequestSuccess({required this.token});
}
