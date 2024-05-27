import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/auth/login_page_bloc.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class NormalLoginTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String fieldText;
  final IconData icon;
  final LoginPageBloc loginBloc;

  const NormalLoginTextfield({
    super.key,
    required this.controller,
    required this.fieldText,
    required this.icon,
    required this.loginBloc,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, bool>(builder: (context, state) {
      return TextField(
        controller: controller,
        style: const TextStyle(
          color: AppColors.fontColor,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: fieldText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: loginBloc.state ? AppColors.artist2 : AppColors.listener4,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: loginBloc.state ? AppColors.artist2 : AppColors.listener4,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: loginBloc.state ? AppColors.artist2 : AppColors.listener4,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            // Icons.mail,
            icon,
            color: loginBloc.state ? AppColors.artist2 : AppColors.listener4,
          ),
        ),
      );
    });
  }
}

class ErrorLoginTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String errorMessage;
  final String fieldText;
  final IconData icon;
  final LoginPageBloc loginBloc;

  const ErrorLoginTextfield({
    super.key,
    required this.controller,
    required this.errorMessage,
    required this.fieldText,
    required this.icon,
    required this.loginBloc,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: AppColors.fontColor,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: fieldText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: loginBloc.state ? AppColors.artist2 : AppColors.listener4,
            width: 2,
          ),
        ),
        errorText: errorMessage,
        errorStyle: const TextStyle(
            color: Color.fromARGB(255, 203, 117, 117),
            fontSize: 14.0,
            fontWeight: FontWeight.w500),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 178, 52, 52),
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          // Icons.mail,
          icon,
          color: const Color.fromARGB(255, 178, 52, 52),
        ),
      ),
    );
  }
}
