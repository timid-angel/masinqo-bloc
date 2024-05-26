import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:masinqo/domain/auth/login_failure.dart';
import 'package:masinqo/domain/auth/login_success.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';

class AdminAuthEntity {
  final String email;
  final String password;
  late String token;

  AdminAuthEntity({required this.email, required this.password});

  Future<Either<LoginFailure, LoginSuccess>> loginAdmin() async {
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

    final res = await AdminLoginRepository()
        .adminLogin(LoginDTO(email: email, password: password));

    return res.fold((l) {
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      return Left(loginFailure);
    }, (r) {
      token = r.token;
      return Right(LoginSuccess(token: r.token));
    });
  }
}

class ListenerAuthEntity {
  final String email;
  final String password;

  ListenerAuthEntity({required this.email, required this.password});

  Future<Either<LoginFailure, LoginSuccess>> loginListener() async {
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

    final res = await ListenerLoginRepository()
        .listenerLogin(ListenerLoginDTO(email: email, password: password));

    return res.fold((l) {
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      return Left(loginFailure);
    }, (r) {
      return Right(LoginSuccess(token: r.token));
    });
  }
}

class ArtistAuthEntity {
  final String email;
  final String password;

  ArtistAuthEntity({required this.email, required this.password});

  Future<Either<LoginFailure, LoginSuccess>> loginArtist() async {
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

    final res = await ArtistLoginRepository()
        .artistLogin(ArtistLoginDTO(email: email, password: password));

    return res.fold((l) {
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      return Left(loginFailure);
    }, (r) {
      return Right(LoginSuccess(token: r.token));
    });
  }
}
