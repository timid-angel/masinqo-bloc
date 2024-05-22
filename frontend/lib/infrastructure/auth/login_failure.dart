import 'package:masinqo/core.dart';

class LoginRequestFailure extends Failure {
  final String name;
  final String message;
  LoginRequestFailure({required this.name, required this.message});
}
