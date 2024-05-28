import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';
import 'package:masinqo/infrastructure/auth/signup_failure.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';

class ArtistSignupRepository implements ArtistSignupRepositoryInterface {
  final ArtistSignupDataSource dataSource;

  ArtistSignupRepository({required this.dataSource});

  @override
  Future<Either<SignupRequestFailure, SignupRequestSuccess>> signupArtist(
      ArtistSignupDTO artist) async {
    final res = await dataSource.signupArtist(artist);

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
