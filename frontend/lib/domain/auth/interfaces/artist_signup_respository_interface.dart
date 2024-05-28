import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup_failure.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';

abstract class ArtistSignupRepositoryInterface {
  Future<Either<SignupRequestFailure, SignupRequestSuccess>> signupArtist(
      ArtistSignupDTO artist);
}
