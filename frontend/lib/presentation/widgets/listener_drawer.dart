import 'package:flutter/material.dart';

class ListenerDrawer extends StatelessWidget {
  const ListenerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: const Color.fromARGB(235, 0, 0, 0),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    width: 98,
                    height: 98,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Username",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Profile Management",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/listener/profile",
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(
                  context,
                  "/login",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
