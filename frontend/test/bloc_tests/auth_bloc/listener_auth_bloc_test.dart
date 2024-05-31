import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/application/auth/listener_auth_bloc.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';

import 'package:masinqo/infrastructure/auth/listener/listener_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockListenerLoginRepository extends Mock implements ListenerLoginRepository {}

class MockListenerLoginDataSource extends Mock implements ListenerLoginDataSource {}

void main() {
  late MockListenerLoginDataSource mockDataSource;
  late MockListenerLoginRepository mockRepository;
  late ListenerAuthBloc listenerAuthBloc;

  setUp(() {
    mockDataSource = MockListenerLoginDataSource();
    mockRepository = MockListenerLoginRepository();
    listenerAuthBloc = ListenerAuthBloc();
  });

  group('ListenerAuthBloc', () {
    blocTest<ListenerAuthBloc, ListenerAuthState>(
      'emits [Loading, Success] when login succeeds',
      build: () {
        when(() => mockRepository.listenerLogin(any())).thenAnswer(
          (_) async => Right(LoginSuccess(token: 'test_token') as LoginRequestSuccess),
        );
        return listenerAuthBloc;
      },
      act: (bloc) => bloc.add(ListenerLoginEvent(email: 'test@example.com', password: 'password')),
      expect: () => [
        ListenerAuthState(isLoading: true),
        ListenerAuthState(),
      ],
    );

  //   Blog   <ListenerAuthBloc, ListenerAuthEvent>(
  //     'emits [Loading, Error] when login fails',
  //     build: () {
  //         (_) async => Left(LoginFailure()),
  //       );
  //       return ListenerAuthBloc();
  //     },
  //     act: (bloc) => bloc.add(ListenerLoginEvent(email: 'test@example.com', password: 'password')),
  //     expect: () => [
  //       AdminAuthState(isLoading: true),
  //       AdminAuthState(),
  //     ],
  //   );
  // }
  
//   void Blog(String s, {required Null Function() build}) {
//   }
// mixin adminAuthBloc {
// }
