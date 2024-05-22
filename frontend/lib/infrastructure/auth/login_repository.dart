import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

abstract class LoginRepository {
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> adminLogin(
      LoginDTO loginDto);
}
