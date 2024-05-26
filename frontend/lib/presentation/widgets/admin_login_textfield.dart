import 'package:flutter/material.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.fontColor),
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldError extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? errorMessage;
  final bool isPassword;

  const CustomTextFieldError({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    this.errorMessage,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.fontColor),
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        errorText: errorMessage,
      ),
    );
  }
}
