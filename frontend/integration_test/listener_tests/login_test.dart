import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/auth/listener_auth_bloc.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart' as dto;
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_datasource.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockListenerLoginRepository extends Mock implements ListenerLoginRepository {}

class MockListenerLoginDataSource extends Mock implements ListenerLoginDataSource {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockListenerLoginDataSource mockDataSource;
  late MockListenerLoginRepository mockRepository;
  late ListenerAuthBloc listenerAuthBloc;

  setUp(() {
    mockDataSource = MockListenerLoginDataSource();
    mockRepository = MockListenerLoginRepository();
    listenerAuthBloc = ListenerAuthBloc();
  });

  group('Listener Login Integration Test', () {
    testWidgets('Listener Login succeeds', (WidgetTester tester) async {
      final loginDto = dto.ListenerLoginDTO(email: 'test@example.com', password: 'password');
      final token = 'test_token';

      when(() => mockRepository.listenerLogin(loginDto )).thenAnswer((_) async => Right(LoginRequestSuccess(token: token)));
      when(() => mockDataSource.listenerLogin(loginDto )).thenAnswer((_) async => http.Response(json.encode({'token': token}), 200));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ListenerAuthBloc>(
            create: (context) => listenerAuthBloc,
            child:  LoginWidget(),
          ),
        ),
      );
      await tester.tap(find.byKey(Key("asListener")));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle(Duration(seconds: 10));


     
      // expect(find.byType(ListenerHome), findsOne);
    });

  });
}