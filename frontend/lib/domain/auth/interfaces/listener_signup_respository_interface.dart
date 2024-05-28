import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup_failure.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';

abstract class ListenerSignupRepositoryInterface {
  Future<Either<SignupRequestFailure, SignupRequestSuccess>> signupListener(
      ListenerSignupDTO listener);
}
