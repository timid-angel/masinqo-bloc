import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';

class ListenerAppbar extends StatelessWidget {
  const ListenerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 65,
      backgroundColor: const Color.fromARGB(0, 238, 233, 233),
      elevation: 0,
      scrolledUnderElevation: 0.0,
      pinned: false,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      title: Text(
        'Masinqo',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.fontColor,
              fontWeight: FontWeight.w300,
              fontSize: 32,
            ),
      ),
    );
  }
}
