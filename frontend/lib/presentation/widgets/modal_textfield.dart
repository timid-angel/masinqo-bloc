import 'package:flutter/material.dart';

class ModalTextFieldWidget extends StatelessWidget {
  final String? Function(String?) validator;
  final Color color;
  final TextEditingController controller;
  final String hintText;
  final int lineCount;

  const ModalTextFieldWidget({
    super.key,
    required this.validator,
    required this.color,
    required this.controller,
    required this.hintText,
    required this.lineCount,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      validator: validator,
      controller: controller,
      minLines: lineCount,
      maxLines: lineCount,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusColor: color,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      cursorColor: Colors.grey[50],
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 19,
          ),
    );
  }
}
