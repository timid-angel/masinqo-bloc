import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';
import 'package:masinqo/presentation/screens/admin_login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/admin_auth_bloc.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_datasource.dart';
import 'package:masinqo/presentation/screens/admin_home.dart';
import 'package:http/http.dart' as http;


class MockAdminLoginDataSource extends Mock implements AdminLoginDataSource {}

class MockAdminLoginRepository extends Mock implements AdminLoginRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockAdminLoginDataSource mockDataSource;
  late MockAdminLoginRepository mockRepository;
  late AdminAuthBloc adminAuthBloc;

  setUp(() {
    mockDataSource = MockAdminLoginDataSource();
    mockRepository = MockAdminLoginRepository();
    adminAuthBloc = AdminAuthBloc(authRepository: mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(LoginDTO(email: '', password: ''));
  });

  tearDown(() {
    adminAuthBloc.close();
  });

  testWidgets('Admin login success', (WidgetTester tester) async {

    when(() => mockRepository.adminLogin(any())).thenAnswer(
      (_) async => Right(LoginRequestSuccess(token: 'admin_token')),
    );

    when(() => mockDataSource.adminLogin(any())).thenAnswer(
      (_) async => http.Response('{"token": "admin_token"}', 200),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: adminAuthBloc,
          child: AdminLogin(),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('adminEmailField')), 'admin123@gmail.com');
    await tester.enterText(find.byKey(const Key('adminPasswordField')), 'admin123');
    final loginButton = find.byKey(const Key("adminLoginButton"));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();


    await tester.pump(Duration(seconds: 1));

  
    print('Bloc State: ${adminAuthBloc.state}');

    verify(() => mockRepository.adminLogin(any())).called(1);
    expect(adminAuthBloc.state.token, 'admin_token');
    expect(find.byType(AdminHome), findsOneWidget); 
  });
}