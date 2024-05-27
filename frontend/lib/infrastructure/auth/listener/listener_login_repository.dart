import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/domain/auth/interfaces/listener_login_repository_interface.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

class ListenerLoginRepository implements ListenerLoginRepositoryInterface {
  @override
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> listenerLogin(
      ListenerLoginDTO loginDto) async {
    http.Response response =
        await ListenerLoginDataSource().listenerLogin(loginDto);

    if (response.statusCode != 200) {
      return Left(LoginRequestFailure(message: response.body));
    }

    String token = response.headers["set-cookie"] as String;
    return Right(LoginRequestSuccess(token: token));
  }
}

// void main() async {
//   ListenerLoginRepository artistRepo = ListenerLoginRepository();

//   final res = await artistRepo.listenerLogin(
//       ListenerLoginDTO(email: "user12@gmail.com", password: "user11"));

//   res.fold((l) {
//     print(l.message);
//   }, (r) {
//     print(r.token);
//   });
// }
