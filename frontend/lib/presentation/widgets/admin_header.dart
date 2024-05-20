import 'package:flutter/material.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 48,
                height: 48,
              ),
            ),
            const Text(
              'Masinqo',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {},
              tooltip: 'Search',
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/admin");
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
