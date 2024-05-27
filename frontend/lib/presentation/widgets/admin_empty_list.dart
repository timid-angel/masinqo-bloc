import 'package:flutter/material.dart';

class AdminEmptyList extends StatelessWidget {
  const AdminEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/empty_list.png"))),
        height: 400,
        width: 400,
      ),
    );
  }
}
