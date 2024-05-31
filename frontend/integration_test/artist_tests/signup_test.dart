import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_bloc.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_event.dart';
import 'package:masinqo/application/auth/signup/artist_signup/artist_signup_state.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_datasource.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup_success.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:masinqo/presentation/screens/signup.dart';
import 'package:mocktail/mocktail.dart';


class MockArtistSignupRepository extends Mock implements ArtistSignupRepository {}

class MockArtistSignupDataSource extends Mock implements ArtistSignupDataSource {}

class MockArtistSignupBloc extends MockBloc<ASignupEvent, ArtistSignupState>
    implements ArtistSignupBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockArtistSignupRepository artistSignupRepository;
  late MockArtistSignupDataSource artistSignupDataSource;
  late MockArtistSignupBloc artistSignupBloc;

  setUp(() {
    artistSignupRepository = MockArtistSignupRepository();
    artistSignupDataSource = MockArtistSignupDataSource();
    artistSignupBloc = MockArtistSignupBloc();

  });

    setUpAll(() {
    registerFallbackValue(ArtistSignupDTO(email: '', password: '', name: '', confirmPassword: ''));
  });

  tearDown(() {
    artistSignupBloc.close();
  });

  testWidgets('Artist Signup Process', (WidgetTester tester) async {
  
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ArtistSignupRepository>(
            create: (_) => artistSignupRepository,
          ),
          RepositoryProvider<ArtistSignupDataSource>(
            create: (_) => artistSignupDataSource,
          ),
        ],
        child: BlocProvider<ArtistSignupBloc>(
          create: (_) => artistSignupBloc,
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
    final artistOption = find.byKey(const Key('Artist_op'));

    await tester.tap(artistOption);
    await tester.enterText(nameField, 'Test User');
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.enterText(confirmPasswordField, 'password');

 

    when(() => artistSignupRepository.signupArtist(any())).thenAnswer(
      (_) async => Right(SignupRequestSuccess()),
    );

    await tester.tap(signupButton);
    await tester.pump();


expect(find.byType(LoginWidget), findsOneWidget);
  });
}
