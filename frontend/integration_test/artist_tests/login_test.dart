import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart' as dto;
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockArtistLoginRepository extends Mock implements ArtistLoginRepository {}

class MockArtistLoginDataSource extends Mock implements ArtistLoginDataSource {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockArtistLoginDataSource mockDataSource;
  late MockArtistLoginRepository mockRepository;
  late ArtistAuthBloc artistAuthBloc;

  setUp(() {
    mockDataSource = MockArtistLoginDataSource();
    mockRepository = MockArtistLoginRepository();
    artistAuthBloc = ArtistAuthBloc();
  });

  group('Artist Login Integration Test', () {
    testWidgets('Artist Login succeeds', (WidgetTester tester) async {
      final loginDto = dto.ArtistLoginDTO(email: 'test@example.com', password: 'password');
      final token = 'test_token';

      when(() => mockRepository.artistLogin(loginDto)).thenAnswer((_) async => Right(LoginRequestSuccess(token: token)));
      when(() => mockDataSource.artistLogin(loginDto)).thenAnswer((_) async => http.Response(json.encode({'token': token}), 200));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArtistAuthBloc>(
            create: (context) => artistAuthBloc,
            child:  LoginWidget(),
          ),
        ),
      );
      await tester.tap(find.byKey(Key("asArtist")));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle(Duration(seconds: 10));


     
      // expect(find.byType(ArtistHomePage), findsOne);
    });

  });
}