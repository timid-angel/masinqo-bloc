import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isArtist;
  final Icon? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.isArtist,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 17, color: Colors.white),
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
