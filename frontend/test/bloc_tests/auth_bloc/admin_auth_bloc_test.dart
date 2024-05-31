import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/application/auth/listener_auth_bloc.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';
import  'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockListenerAuthEntity extends Mock implements ListenerAuthEntity {}
class MockListenerLoginRepository extends Mock implements ListenerLoginRepository {}

void main() {
  group('ListenerAuthBloc', () {
    late ListenerAuthBloc listenerAuthBloc;
    late MockListenerLoginRepository mockListenerLoginRepository;

    setUp(() {
      mockListenerLoginRepository = MockListenerLoginRepository();
      listenerAuthBloc = ListenerAuthBloc(authRepository: mockListenerLoginRepository);
    });

    tearDown(() {
      listenerAuthBloc.close();
    });

    test('initial state is correct', () {
      expect(listenerAuthBloc.state, ListenerAuthState());
    });

    blocTest<ListenerAuthBloc, ListenerAuthState>(
      'emits [Loading, Success] when successful login',
      build: () {
        when(() => mockListenerLoginRepository.listenerLogin(any()))
          .thenAnswer((_) async => Right(LoginSuccess(token: 'token')));
        return listenerAuthBloc;
      },
      act: (bloc) => bloc.add(ListenerLoginEvent(email: 'test@example.com', password: 'password')),
      expect: () => [
        ListenerAuthState(isLoading: true),
        ListenerAuthState(token: 'token'),
      ],
    );

    blocTest<ListenerAuthBloc, ListenerAuthState>(
      'emits [Loading, Error] when login fails',
      build: () {
        when(() => mockListenerLoginRepository.listenerLogin(any()))
          .thenAnswer((_) async => Left(LoginFailure(messages: ['Invalid Email'])));
        return listenerAuthBloc;
      },
      act: (bloc) => bloc.add(ListenerLoginEvent(email: 'test@example.com', password: 'password')),
      expect: () => [
        ListenerAuthState(isLoading: true),
        ListenerAuthState(errors: ['Invalid Email']),
      ],
    );
  });
}
