import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/auth/admin_auth_bloc.dart';
import 'package:masinqo/application/auth/login_form/admin_login/admin_login_bloc.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/presentation/screens/admin_login.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';
import 'package:masinqo/presentation/widgets/admin_login_textfield.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';

void main() {
  testWidgets('Admin Login Test', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AdminAuthBloc>(
              create: (_) =>
                  AdminAuthBloc(authRepository: AdminLoginRepository())),
          BlocProvider<EmailErrorBloc>(create: (_) => EmailErrorBloc()),
          BlocProvider<PasswordErrorBloc>(create: (_) => PasswordErrorBloc()),
          BlocProvider<LoginLoadingBloc>(create: (_) => LoginLoadingBloc()),
        ],
        child: MaterialApp(home: AdminLogin()),
      ),
    );

    expect(find.widgetWithText(Brand, 'Masinqo Admins'), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.widgetWithText(CustomElevatedButton, 'Login'), findsOneWidget);

    final loginButton = find.widgetWithText(CustomElevatedButton, 'Login');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Invalid Email'), findsOneWidget);
    expect(find.text('The password is too short'), findsOneWidget);
  });
}
