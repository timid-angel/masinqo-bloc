import 'package:flutter/material.dart';
import 'package:masinqo/presentation/screens/login.dart';

class LoginOptionButton extends StatelessWidget {
  const LoginOptionButton({
    super.key,
    required this.isArtist,
    required this.parent,
    required this.primaryColor,
    required this.buttonText,
    required this.toValue,
  });

  final bool isArtist;
  final LoginWidgetState parent;
  final Color primaryColor;
  final String buttonText;
  final bool toValue;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        parent.refreshState(toValue);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
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
