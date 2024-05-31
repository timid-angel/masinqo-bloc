import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockArtistAuthEntity extends Mock implements ArtistAuthEntity {}
class MockArtistLoginRepository extends Mock implements ArtistLoginRepository {}

void main() {
  group('ArtistAuthBloc', () {
    late ArtistAuthBloc artistAuthBloc;
    late MockArtistLoginRepository mockArtistLoginRepository;

    setUp(() {
      mockArtistLoginRepository = MockArtistLoginRepository();
      artistAuthBloc = ArtistAuthBloc(authRepository: mockArtistLoginRepository);
    });

    tearDown(() {
      artistAuthBloc.close();
    });

    test('initial state is correct', () {
      expect(artistAuthBloc.state, ArtistAuthState());
    });

    blocTest<ArtistAuthBloc, ArtistAuthState>(
      'emits [Loading, Success] when successful login',
      build: () {
        when(() => mockArtistLoginRepository.artistLogin(any())).thenAnswer(
          (_) async => Right(LoginSuccess(token: 'token')),
        );
        return artistAuthBloc;
      },
      act: (bloc) => bloc.add(ArtistLoginEvent(email: 'test@example.com', password: 'password')),
      expect: () => [
        ArtistAuthState(isLoading: true),
        ArtistAuthState(token: 'token'),
      ],
    );

    blocTest<ArtistAuthBloc, ArtistAuthState>(
      'emits [Loading, Error] when login fails',
      build: () {
        when(() => mockArtistLoginRepository.artistLogin(any())).thenAnswer(
          (_) async => Left(LoginFailure(messages: ['Invalid Email'])),
        );
        return artistAuthBloc;
      },
      act: (bloc) => bloc.add(ArtistLoginEvent(email: 'test@example.com', password: 'password')),
      expect: () => [
        ArtistAuthState(isLoading: true),
        ArtistAuthState(errors: ['Invalid Email']),
      ],
    );
  });
}
