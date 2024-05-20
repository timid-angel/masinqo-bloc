import 'package:flutter/material.dart';

class ModalHeadingWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const ModalHeadingWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(width: 10),
        Icon(icon)
      ],
    );
  }
}
