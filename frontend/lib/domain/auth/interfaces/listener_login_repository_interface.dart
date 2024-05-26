
import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';

abstract class ListenerLoginRepositoryInterface {
  Future<Either<Failure, Success>> listenerLogin(ListenerLoginDTO loginDto);
}