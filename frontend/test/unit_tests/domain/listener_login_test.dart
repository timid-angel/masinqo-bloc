import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'listener_login_test.mocks.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';

@GenerateMocks([ListenerLoginRepository])
class MockListenerEntity extends Mock implements ListenerAuthEntity {
  MockListenerEntity(
      {required String email,
      required String password,
      required ListenerLoginRepository repository});
}

void main() {
  group('ListenerAuthEntity', () {
    test('returns LoginFailure when email is invalid', () async {
      final authEntity =
          ListenerAuthEntity(email: 'invalid', password: 'password123');

      final result = await authEntity.loginListener();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    test('returns LoginFailure when password is too short', () async {
      final authEntity =
          ListenerAuthEntity(email: 'test@example.com', password: '123');

      final result = await authEntity.loginListener();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    // test('returns LoginSuccess when email and password are valid', () async {
    //   final mockRepo = MockListenerLoginRepository();
    //   when(mockRepo.listenerLogin(any)).thenAnswer(
    //       (_) async => Right(LoginRequestSuccess(token: 'valid_token')));
    //   final authEntity = MockListenerEntity(
    //       email: 'test@example.com',
    //       password: 'password123',
    //       repository: mockRepo);

    //   final result = await authEntity.loginListener();

    //   expect(result.isRight(), true);
    //   expect(result.fold((l) => null, (r) => r), isA<LoginSuccess>());
    //   verify(mockRepo.listenerLogin(any)).called(1);
    // });
  });
}
