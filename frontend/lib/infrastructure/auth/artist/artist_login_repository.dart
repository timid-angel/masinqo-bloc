import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/domain/auth/artist_login_repository_interface.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ArtistLoginRepository implements ArtistLoginRepositoryInterface {
  final SecureStorageService secureStorageService;

  ArtistLoginRepository({required this.secureStorageService});

  @override
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> artistLogin(ArtistLoginDTO loginDto) async {
    try {
      http.Response response = await ArtistLoginDataSource().artistLogin(loginDto);

      if (response.statusCode != 200) {
        return Left(LoginRequestFailure(name: "login_error", message: response.body));
      }

      String token = response.headers["set-cookie"] as String;
      await secureStorageService.writeToken(token);
      return Right(LoginRequestSuccess(token: token));
    } catch (e) {
      return Left(LoginRequestFailure(name: "login_error", message: "An error occurred"));
    }
  }
}
