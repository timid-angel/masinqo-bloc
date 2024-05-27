import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/domain/auth/interfaces/artist_login_repository_interface.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

class ArtistLoginRepository implements ArtistLoginRepositoryInterface {
  @override
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> artistLogin(
      ArtistLoginDTO loginDto) async {
    http.Response response =
        await ArtistLoginDataSource().artistLogin(loginDto);

    if (response.statusCode != 200) {
      return Left(LoginRequestFailure(message: response.body));
    }

    String token = response.headers["set-cookie"] as String;
    return Right(LoginRequestSuccess(token: token));
  }
}

// void main() async {
//   ArtistLoginRepository artistRepo = ArtistLoginRepository();

//   final res = await artistRepo.artistLogin(
//       ArtistLoginDTO(email: "dynamic11@gmail.com", password: "dynamic11"));

//   res.fold((l) {
//     print(l.message);
//   }, (r) {
//     print(r.token);
//   });
// }
