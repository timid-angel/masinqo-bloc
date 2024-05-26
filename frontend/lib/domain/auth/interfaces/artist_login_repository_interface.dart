import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/core.dart';

abstract class ArtistLoginRepositoryInterface {
  Future<Either<Failure, Success>> artistLogin(ArtistLoginDTO loginDto);
}
