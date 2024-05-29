import 'package:flutter/material.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isArtist;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextEditingController controller; // Add controller argument

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.isArtist,
      this.prefixIcon,
      required this.controller,
      this.obscureText = false // Define controller as a required argument
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Assign the controller to the TextField
      style: const TextStyle(fontSize: 17, color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isArtist ? AppColors.artist2 : AppColors.listener2,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isArtist ? AppColors.artist2 : AppColors.listener4,
            width: 2,
          ),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
