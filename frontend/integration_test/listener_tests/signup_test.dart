import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_event.dart';
import 'package:masinqo/application/auth/signup/listener_signup/listener_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:masinqo/presentation/screens/signup.dart';
import 'package:mocktail/mocktail.dart';


class MockListenerSignupRepository extends Mock implements ListenerSignupRepository {}

class MockListenerSignupDataSource extends Mock implements ListenerSignupDataSource {}

class MockListenerSignupBloc extends MockBloc<LSignupEvent, ListenerSignupState>
    implements ListenerSignupBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockListenerSignupRepository listenerSignupRepository;
  late MockListenerSignupDataSource listenerSignupDataSource;
  late MockListenerSignupBloc listenerSignupBloc;

  setUp(() {
    listenerSignupRepository = MockListenerSignupRepository();
    listenerSignupDataSource = MockListenerSignupDataSource();
    listenerSignupBloc = MockListenerSignupBloc();

  });

    setUpAll(() {
    registerFallbackValue(ListenerSignupDTO(email: '', password: '', name: '', confirmPassword: ''));
  });

  tearDown(() {
    listenerSignupBloc.close();
  });

  testWidgets('Listener Signup Process', (WidgetTester tester) async {
  
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ListenerSignupRepository>(
            create: (_) => listenerSignupRepository,
          ),
          RepositoryProvider<ListenerSignupDataSource>(
            create: (_) => listenerSignupDataSource,
          ),
        ],
        child: BlocProvider<ListenerSignupBloc>(
          create: (_) => listenerSignupBloc,
          child: MaterialApp(
            home: SignupWidget(),
          ),
        ),
      ),
    );

    final nameField = find.byKey(const Key('username_field'));
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final confirmPasswordField = find.byKey(const Key('confirm_password_field'));
    final signupButton = find.byKey(const Key('signup_button'));
    final listenerOption = find.byKey(const Key('Listener_op'));

    await tester.tap(listenerOption);
    await tester.enterText(nameField, 'Test User');
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.enterText(confirmPasswordField, 'password');

 

    when(() => listenerSignupRepository.signupListener(any())).thenAnswer(
      (_) async => Right(SignupRequestSuccess()),
    );

    await tester.tap(signupButton);
    await tester.pump();


expect(find.byType(LoginWidget), findsOneWidget);
  });
}
