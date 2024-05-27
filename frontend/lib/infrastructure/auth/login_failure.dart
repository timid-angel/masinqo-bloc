import 'package:masinqo/core.dart';

class LoginRequestFailure implements Failure {
  final String message;

  LoginRequestFailure({required this.message});
}
