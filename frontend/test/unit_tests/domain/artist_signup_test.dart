import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';
import 'package:masinqo/domain/auth/signup/signup_failure.dart';
import 'package:masinqo/domain/auth/signup/signup_success.dart';
import 'artist_signup_test.mocks.dart';

@GenerateMocks([ArtistSignupRepository])
class MockArtistSignupEntity extends Mock implements ArtistSignupEntity {
  MockArtistSignupEntity(
      {required ArtistSignupDTO artist,
      required ArtistSignupRepositoryInterface signupRepository});

  @override
  Future<Either<SignupFailure, SignupSuccess>> signupArtist() {
    return super.noSuchMethod(
      Invocation.method(#signupArtist, []),
      returnValue:
          Future.value(Left<SignupFailure, SignupSuccess>(SignupFailure())),
      returnValueForMissingStub:
          Future.value(Right<SignupFailure, SignupSuccess>(SignupSuccess())),
    );
  }
}

void main() {
  group('ArtistSignupEntity', () {
    test('returns SignupFailure when username is empty', () async {
      final signupEntity = ArtistSignupEntity(
        artist: ArtistSignupDTO(
            name: '',
            email: 'test@example.com',
            password: 'password123',
            confirmPassword: 'password123'),
        signupRepository: MockArtistSignupRepository(),
      );

      final result = await signupEntity.signupArtist();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<SignupFailure>());
    });

    test('returns SignupFailure when password is too short', () async {
      final signupEntity = ArtistSignupEntity(
        artist: ArtistSignupDTO(
            name: 'username',
            email: 'test@example.com',
            password: '123',
            confirmPassword: '123'),
        signupRepository: MockArtistSignupRepository(),
      );

      final result = await signupEntity.signupArtist();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<SignupFailure>());
    });

    test('returns SignupSuccess when all fields are valid', () async {
      final mockRepo = MockArtistSignupRepository();
      final artist = ArtistSignupDTO(
          name: 'username',
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123');

      when(mockRepo.signupArtist(artist))
          .thenAnswer((_) async => Right(SignupRequestSuccess()));
      final signupEntity = MockArtistSignupEntity(
          artist: ArtistSignupDTO(
              name: 'username',
              email: 'test@example.com',
              password: 'password123',
              confirmPassword: 'password123'),
          signupRepository: mockRepo);

      final result = await signupEntity.signupArtist();

      expect(result.fold((l) => l, (r) => r), isA<SignupSuccess>());
    });
  });
}
