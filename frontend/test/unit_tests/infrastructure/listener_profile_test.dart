import 'dart:core';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/profile.dart';
import 'package:masinqo/infrastructure/listener/listener_profile/listener_profile_service.dart';
import 'package:mockito/mockito.dart';

class MockListenerProfileService extends Mock
    implements ListenerProfileService {
  @override
  Future<Profile> getProfile(String token) => super.noSuchMethod(
        Invocation.method(#getProfile, [token]),
        returnValue: Future.value(
          Profile(
            name: 'User 1',
            email: 'user1@example.com',
            password: 'password1',
          ),
        ),
        returnValueForMissingStub: Future.value(Profile(
          name: 'User 1',
          email: 'user1@example.com',
          password: 'password1',
        )),
      );

  @override
  Future<void> editProfile(
          String token, String name, String email, String password) =>
      super.noSuchMethod(
        Invocation.method(#editProfile, [token, name, email, password]),
        returnValue: Future.value(null),
        returnValueForMissingStub:
            Future.error(Exception('Failed to edit profile')),
      );
}

void main() {
  group('ListenerProfileService', () {
    test('getProfile returns a profile', () async {
      final mockService = MockListenerProfileService();

      when(mockService.getProfile('token')).thenAnswer(
        (_) async => Profile(
          name: 'User 1',
          email: 'user1@example.com',
          password: 'password1',
        ),
      );

      final profile = await mockService.getProfile('token');

      expect(profile.name, 'User 1');
      expect(profile.email, 'user1@example.com');
    });

    test('getProfile handles errors', () async {
      final mockService = MockListenerProfileService();

      when(mockService.getProfile('token'))
          .thenThrow(Exception('Failed to load profile'));

      expect(() => mockService.getProfile('token'), throwsException);
    });

    test('editProfile edits a profile', () async {
      final mockService = MockListenerProfileService();

      when(mockService.editProfile('token', 'User 1 edited',
              'user1edited@example.com', 'password1edited'))
          .thenAnswer((_) async => null);

      await mockService.editProfile('token', 'User 1 edited',
          'user1edited@example.com', 'password1edited');

      verify(mockService.editProfile('token', 'User 1 edited',
              'user1edited@example.com', 'password1edited'))
          .called(1);
    });

    test('editProfile handles errors', () async {
      final mockService = MockListenerProfileService();

      when(mockService.editProfile('token', 'User 1 edited',
              'user1edited@example.com', 'password1edited'))
          .thenThrow(Exception('Failed to edit profile'));

      expect(
          () => mockService.editProfile('token', 'User 1 edited',
              'user1edited@example.com', 'password1edited'),
          throwsException);
    });
  });
}
