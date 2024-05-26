import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/auth/login_dto.dart';

abstract class LoginRepositoryInterface {
  Future<Either<Failure, Success>> adminLogin(LoginDTO loginDto);
}
