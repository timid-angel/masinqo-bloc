import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerHeight: 0,
      indicatorColor: AppColors.listener2,
      splashBorderRadius: BorderRadius.circular(5),
      tabs: const [
        Tab(
          icon: Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.favorite_border_outlined,
            color: Colors.white,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.library_music,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
