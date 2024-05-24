import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../temp/data/artist_data.dart';

class ArtistDrawer extends StatelessWidget {
  const ArtistDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String artistName = artistData.last.name;

    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF39DCF3),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/sample_profile_picture/weyes_blood.jpg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    artistName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Divider(color: Color.fromARGB(255, 156, 153, 153)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Profile Management',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.pushNamed("artist_profile");
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color.fromARGB(255, 241, 211, 211)),
              ),
              onTap: () {
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
