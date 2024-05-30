import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/application/listener/listener_profile/profile_events.dart';

class ListenerDrawer extends StatelessWidget {
  final String token;

  const ListenerDrawer({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchProfile(token: token));
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
                final args = ProfileArgument(
                    token: token, profileBloc: context.read<ProfileBloc>());
                context.pushNamed("listener_profile", extra: args);
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
                context.go("/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileArgument {
  final String token;
  final ProfileBloc profileBloc;

  ProfileArgument({required this.token, required this.profileBloc});
}
