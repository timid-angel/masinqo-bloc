import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'artist_login_test.mocks.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';

@GenerateMocks([ArtistLoginRepository])
class MockArtistEntity extends Mock implements ArtistAuthEntity {
  MockArtistEntity(
      {required String email,
      required String password,
      required ArtistLoginRepository repository});

  @override
  Future<Either<LoginFailure, LoginSuccess>> loginArtist() {
    return super.noSuchMethod(
      Invocation.method(#signupArtist, []),
      returnValue:
          Future.value(Left<LoginFailure, LoginSuccess>(LoginFailure())),
      returnValueForMissingStub: Future.value(Right<LoginFailure, LoginSuccess>(
          LoginSuccess(token: 'valid_token'))),
    );
  }
}

void main() {
  group('ArtistAuthEntity', () {
    test('returns LoginFailure when email is invalid', () async {
      final authEntity =
          ArtistAuthEntity(email: 'invalid', password: 'password123');

      final result = await authEntity.loginArtist();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    test('returns LoginFailure when password is too short', () async {
      final authEntity =
          ArtistAuthEntity(email: 'test@example.com', password: '123');

      final result = await authEntity.loginArtist();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    test('returns LoginSuccess when email and password are valid', () async {
      final mockRepo = MockArtistLoginRepository();
      final artist = ArtistLoginDTO(
        email: 'test@example.com',
        password: 'password123',
      );
      when(mockRepo.artistLogin(artist)).thenAnswer(
          (_) async => Right(LoginRequestSuccess(token: 'valid_token')));
      final authEntity = MockArtistEntity(
          email: 'test@example.com',
          password: 'password123',
          repository: mockRepo);

      final result = await authEntity.loginArtist();

      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r), isA<LoginSuccess>());
    });
  });
}
