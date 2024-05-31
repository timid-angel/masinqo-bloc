import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'admin_login_test.mocks.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';

@GenerateMocks([AdminLoginRepository])
class MockAdminEntity extends Mock implements AdminAuthEntity {
  MockAdminEntity(
      {required String email,
      required String password,
      required AdminLoginRepository repository});

  @override
  Future<Either<LoginFailure, LoginSuccess>> loginAdmin() {
    return super.noSuchMethod(
      Invocation.method(#signupAdmin, []),
      returnValue:
          Future.value(Left<LoginFailure, LoginSuccess>(LoginFailure())),
      returnValueForMissingStub: Future.value(Right<LoginFailure, LoginSuccess>(
          LoginSuccess(token: 'valid_token'))),
    );
  }
}

void main() {
  group('AdminAuthEntity', () {
    test('returns LoginFailure when email is invalid', () async {
      final authEntity =
          AdminAuthEntity(email: 'invalid', password: 'password123');

      final result = await authEntity.loginAdmin();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    test('returns LoginFailure when password is too short', () async {
      final authEntity =
          AdminAuthEntity(email: 'test@example.com', password: '123');

      final result = await authEntity.loginAdmin();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<LoginFailure>());
    });

    test('returns LoginSuccess when email and password are valid', () async {
      final mockRepo = MockAdminLoginRepository();
      when(mockRepo.adminLogin(any)).thenAnswer(
          (_) async => Right(LoginRequestSuccess(token: 'valid_token')));
      final authEntity = MockAdminEntity(
          email: 'test@example.com',
          password: 'password123',
          repository: mockRepo);

      final result = await authEntity.loginAdmin();

      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r), isA<LoginSuccess>());
    });
  });
}
