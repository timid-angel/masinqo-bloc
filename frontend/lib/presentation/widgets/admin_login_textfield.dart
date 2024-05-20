import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: AppColors.fontColor),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        prefixIcon: prefixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    );
  }
}
