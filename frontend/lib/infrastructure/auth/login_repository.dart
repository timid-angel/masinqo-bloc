import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/auth/login_dto.dart';
import 'package:masinqo/infrastructure/core/failure.dart';

// replace later
class Success {
  final String token;
  Success({required this.token});
}

class LoginRepository {
  final String url = "http://localhost:3000";

  Future<Either<Failure, Success>> adminLogin(LoginDTO loginDto) async {
    http.Response response =
        await http.post(Uri.parse("$url/auth/admin/login"), body: {
      "email": loginDto.email,
      "password": loginDto.password,
    });

    if (!(response.statusCode == 200)) {
      return Left(Failure(name: "login_error", message: response.body));
    }

    String token = response.headers["set-cookie"] as String;
    return Right(Success(token: token));
  }
}

// void main() async {
//   LoginRepository loginRepo = LoginRepository();
//   LoginDTO admin = LoginDTO(email: "admin123@gmail.com", password: "admin123");
//   final res = await loginRepo.adminLogin(admin);
//   res.fold((l) => (print(l.message)), (r) => print(r.token));
// }
