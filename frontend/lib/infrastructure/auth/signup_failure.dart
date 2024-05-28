import 'package:masinqo/core.dart';

class SignupRequestFailure implements Failure {
  final String message;

  SignupRequestFailure({required this.message});
}
