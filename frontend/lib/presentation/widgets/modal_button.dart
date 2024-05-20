import 'package:flutter/material.dart';

class ModalButtonWidget extends StatelessWidget {
  final dynamic Function() onPressed;
  final String text;
  final Color bgColor;
  final TextStyle textStyle;
  const ModalButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.bgColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        textStyle: textStyle,
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
