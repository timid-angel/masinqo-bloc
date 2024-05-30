import 'package:masinqo/core.dart';

class SignupRequestFailure implements Failure {
  @override
  final String message;

  SignupRequestFailure({required this.message});
}
