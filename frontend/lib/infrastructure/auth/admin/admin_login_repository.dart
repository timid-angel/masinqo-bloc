import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/domain/auth/interfaces/admin_login_repository_interface.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

class AdminLoginRepository implements AdminLoginRepositoryInterface {
  @override
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> adminLogin(
      LoginDTO loginDto) async {
    http.Response response = await AdminLoginDataSource().adminLogin(loginDto);

    if (!(response.statusCode == 200)) {
      return Left(
          LoginRequestFailure(name: "login_error", message: response.body));
    }

    String token = response.headers["set-cookie"] as String;
    return Right(LoginRequestSuccess(token: token));
  }
}


// void main() async {
//   LoginDataSource loginRepo = LoginDataSource();
//   LoginDTO admin = LoginDTO(email: "admin123@gmail.com", password: "admin13");
//   final res = await loginRepo.adminLogin(admin);
//   res.fold((l) => (print(l.message)), (r) => print(r.token));
// }
