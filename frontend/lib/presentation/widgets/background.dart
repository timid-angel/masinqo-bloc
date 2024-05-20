import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.black,
            AppColors.blueish,
            AppColors.black,
            AppColors.greenish
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: child,
    );
  }
}
