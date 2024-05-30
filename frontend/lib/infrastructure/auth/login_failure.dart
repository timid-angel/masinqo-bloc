import 'package:masinqo/core.dart';

class LoginRequestFailure implements Failure {
  @override
  final String message;

  LoginRequestFailure({required this.message});
}
