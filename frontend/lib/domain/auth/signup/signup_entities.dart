import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';
import 'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';
import 'package:masinqo/domain/auth/signup/signup_failure.dart';
import 'package:masinqo/domain/auth/signup/signup_success.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class ListenerSignupEntity {
  final ListenerSignupRepositoryInterface signupRepository;
  final ListenerSignupDTO listener;

  ListenerSignupEntity({
    required this.listener,
    required this.signupRepository,
  });

  Future<Either<SignupFailure, SignupSuccess>> signupListener() async {
    SignupFailure signupFailure = SignupFailure();

    if (listener.name.isEmpty) {
      signupFailure.messages.add("Username can not be empty");
    }

    if (!EmailValidator.validate(listener.email)) {
      signupFailure.messages.add("Invalid Email");
    }

    if (listener.password.length < 6) {
      signupFailure.messages.add("The password is too short");
    }

    if (listener.password != listener.confirmPassword) {
      signupFailure.messages.add("The passwords don't match");
    }

    if (signupFailure.messages.isNotEmpty) {
      return Left(signupFailure);
    }

    final res = await signupRepository.signupListener(listener);

    return res.fold((l) {
      signupFailure.messages.add(
          l.message == "Account with the provided email already exists"
              ? l.message
              : "Signup failed. Please try again");
      return Left(signupFailure);
    }, (r) {
      return Right(SignupSuccess());
    });
  }
}

class ArtistSignupEntity {
  final ArtistSignupRepositoryInterface signupRepository;
  final ArtistSignupDTO artist;

  ArtistSignupEntity({
    required this.artist,
    required this.signupRepository,
  });

  Future<Either<SignupFailure, SignupSuccess>> signupArtist() async {
    SignupFailure signupFailure = SignupFailure();

    if (artist.name.isEmpty) {
      signupFailure.messages.add("Username can not be empty");
    }

    if (!EmailValidator.validate(artist.email)) {
      signupFailure.messages.add("Invalid Email");
    }

    if (artist.password.length < 6) {
      signupFailure.messages.add("The password is too short");
    }

    if (artist.password != artist.confirmPassword) {
      signupFailure.messages.add("The passwords don't match");
    }

    if (signupFailure.messages.isNotEmpty) {
      return Left(signupFailure);
    }

    final res = await signupRepository.signupArtist(artist);

    return res.fold((l) {
      signupFailure.messages.add(
          l.message == "Account with the provided email already exists"
              ? l.message
              : "Signup failed. Please try again");
      return Left(signupFailure);
    }, (r) {
      return Right(SignupSuccess());
    });
  }
}
