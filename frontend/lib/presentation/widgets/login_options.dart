import 'package:flutter/material.dart';
import 'package:masinqo/application/auth/auth_event.dart';
import 'package:masinqo/application/auth/login_page_bloc.dart';

class LoginOptionButton extends StatelessWidget {
  final bool isArtist;
  final Color primaryColor;
  final String buttonText;
  final bool toValue;
  final LoginPageBloc loginBloc;

  const LoginOptionButton({
    super.key,
    required this.isArtist,
    required this.primaryColor,
    required this.buttonText,
    required this.toValue,
    required this.loginBloc,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        loginBloc.add(SwitchRole(toValue: toValue));
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 17,
          color: primaryColor,
        ),
      ),
    );
  }
}
