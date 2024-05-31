import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';
import 'package:masinqo/domain/auth/signup/signup_failure.dart';
import 'package:masinqo/domain/auth/signup/signup_success.dart';
import 'listener_signup_test.mocks.dart';

@GenerateMocks([ListenerSignupRepository])
class MockListenerSignupEntity extends Mock implements ListenerSignupEntity {
  MockListenerSignupEntity(
      {required ListenerSignupDTO listener,
      required ListenerSignupRepositoryInterface signupRepository});

  @override
  Future<Either<SignupFailure, SignupSuccess>> signupListener() {
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
  group('ListenerSignupEntity', () {
    test('returns SignupFailure when username is empty', () async {
      final signupEntity = ListenerSignupEntity(
        listener: ListenerSignupDTO(
            name: '',
            email: 'test@example.com',
            password: 'password123',
            confirmPassword: 'password123'),
        signupRepository: MockListenerSignupRepository(),
      );

      final result = await signupEntity.signupListener();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<SignupFailure>());
    });

    test('returns SignupFailure when password is too short', () async {
      final signupEntity = ListenerSignupEntity(
        listener: ListenerSignupDTO(
            name: 'username',
            email: 'test@example.com',
            password: '123',
            confirmPassword: '123'),
        signupRepository: MockListenerSignupRepository(),
      );

      final result = await signupEntity.signupListener();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<SignupFailure>());
    });

    test('returns SignupSuccess when all fields are valid', () async {
      final mockRepo = MockListenerSignupRepository();
      final listener = ListenerSignupDTO(
          name: 'username',
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123');

      when(mockRepo.signupListener(listener))
          .thenAnswer((_) async => Right(SignupRequestSuccess()));
      final signupEntity = MockListenerSignupEntity(
          listener: ListenerSignupDTO(
              name: 'username',
              email: 'test@example.com',
              password: 'password123',
              confirmPassword: 'password123'),
          signupRepository: mockRepo);

      final result = await signupEntity.signupListener();

      expect(result.fold((l) => l, (r) => r), isA<SignupSuccess>());
    });
  });
}
