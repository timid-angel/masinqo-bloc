import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:masinqo/domain/auth/login_failure.dart';
import 'package:masinqo/domain/auth/login_success.dart';
import 'package:masinqo/infrastructure/auth/login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_repository.dart';

class User {
  final String email;
  final String password;
  final String role;
  late String token;

  User({required this.email, required this.password, required this.role});

  Future<Either<LoginFailure, LoginSuccess>> loginUser() async {
    LoginFailure loginFailure = LoginFailure();
    if (password.length < 6) {
      loginFailure.messages.add("The password is too short");
    }

    if (!EmailValidator.validate(email)) {
      loginFailure.messages.add("Invalid Email");
    }

    if (loginFailure.messages.isNotEmpty) {
      return Left(loginFailure);
    }

    final res = await LoginRepository()
        .adminLogin(LoginDTO(email: email, password: password));

    Either<LoginFailure, LoginSuccess> response = Left(loginFailure);
    res.fold((l) {
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      response = Left(loginFailure);
    }, (r) {
      token = r.token;
      response = Right(LoginSuccess(token: r.token));
    });

    return Future(() => response);
  }
}
