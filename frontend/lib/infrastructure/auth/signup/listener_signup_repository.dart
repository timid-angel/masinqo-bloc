import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';
import 'package:masinqo/infrastructure/auth/signup_failure.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';

class ListenerSignupRepository implements ListenerSignupRepositoryInterface {
  final ListenerSignupDataSource dataSource;

  ListenerSignupRepository({required this.dataSource});

  @override
  Future<Either<SignupRequestFailure, SignupRequestSuccess>> signupListener(
      ListenerSignupDTO listener) async {
    final res = await dataSource.signupListener(listener);

    if (res.statusCode == 500) {
      return Left(SignupRequestFailure(
          message: "There is an account associated with that email"));
    }

    if (res.statusCode != 201) {
      final decodedRes = jsonDecode(res.body);
      return Left(SignupRequestFailure(message: decodedRes["message"]));
    }

    return Right(SignupRequestSuccess());
  }
}
