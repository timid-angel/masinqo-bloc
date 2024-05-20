import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  const Brand({
    super.key,
    required this.text,
    required this.size,
  });
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 135,
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
