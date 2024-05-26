
import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/auth/login_failure.dart';
import 'package:masinqo/domain/auth/login_success.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';

abstract class ArtistLoginRepositoryInterface {
  Future<Either<LoginFailure, LoginSuccess>> artistLogin(ArtistLoginDTO loginDto);
}


