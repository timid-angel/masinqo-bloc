import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';

abstract class AdminLoginRepositoryInterface {
  Future<Either<Failure, Success>> adminLogin(LoginDTO loginDto);
}
