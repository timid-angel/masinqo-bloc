import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/auth/artist/artist_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

class MockArtistLoginDataSource extends Mock implements ArtistLoginDataSource {}

void main() {
  MockArtistLoginDataSource mockDataSource;
  ArtistLoginRepository artistLoginRepository;

  mockDataSource = MockArtistLoginDataSource();
  artistLoginRepository = ArtistLoginRepository();

  test('should return LoginRequestFailure when status code is not 200',
      () async {
    final loginDto =
        ArtistLoginDTO(email: 'test@example.com', password: 'password');
    final http.Response failureResponse = http.Response('Unauthorized', 401);
    when(mockDataSource.artistLogin(loginDto))
        .thenAnswer((_) async => failureResponse);

    final result = await artistLoginRepository.artistLogin(loginDto);
    expect(result, Left(LoginRequestFailure(message: 'Unauthorized')));
    verify(mockDataSource.artistLogin(loginDto)).called(1);
  });

  test('should return LoginRequestSuccess when status code is 200', () async {
    final loginDto =
        ArtistLoginDTO(email: 'test@example.com', password: 'password');
    final http.Response successResponse =
        http.Response('Success', 200, headers: {'set-cookie': 'some_token'});

    when(mockDataSource.artistLogin(loginDto))
        .thenAnswer((_) async => successResponse);
    final result = await artistLoginRepository.artistLogin(loginDto);
    expect(result, Right(LoginRequestSuccess(token: 'some_token')));
    verify(mockDataSource.artistLogin(loginDto)).called(1);
  });
}
