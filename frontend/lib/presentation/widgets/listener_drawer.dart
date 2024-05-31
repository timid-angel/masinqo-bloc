import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/application/listener/listener_profile/profile_events.dart';
import 'package:masinqo/application/listener/listener_profile/profile_state.dart';

class ListenerDrawer extends StatelessWidget {
  final String token;
  final ProfileBloc profileBloc;

  const ListenerDrawer(
      {super.key, required this.token, required this.profileBloc});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile(token: token));
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: const Color.fromARGB(235, 0, 0, 0),
        child: ListView(
          children: [
            DrawerHeader(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadedProfile) {
                    return Column(
                      children: [
                        Container(
                          width: 98,
                          height: 98,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.profile.name,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    );
                  } else if (state is ErrorProfile) {
                    return Text(
                      'Error: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return const Text(
                      'No profile information available',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
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
                final args =
                    ProfileArgument(token: token, profileBloc: profileBloc);
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
