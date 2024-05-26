import 'package:flutter/material.dart';
import 'package:masinqo/presentation/core/theme/app_theme_data.dart';
import 'package:masinqo/presentation/screens/admin_home.dart';
import 'package:masinqo/presentation/screens/admin_login.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/screens/artist_home.dart';
import 'package:masinqo/presentation/screens/artist_profile.dart';
import 'package:masinqo/presentation/screens/listener.dart';
import 'package:masinqo/presentation/screens/listener_add_playlist.dart';
import 'package:masinqo/presentation/screens/listener_album.dart';
import 'package:masinqo/presentation/screens/listener_playlist.dart';
import 'package:masinqo/presentation/screens/listener_profile.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:masinqo/presentation/screens/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/temp/models/albums.dart';
import 'package:masinqo/temp/models/playlist.dart';
import 'package:masinqo/temp/models/route_models/listener_homepage_data.dart';

final _router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => const LoginWidget(),
    ),
    GoRoute(
      name: "signup",
      path: '/signup',
      builder: (context, state) => const SignupWidget(),
    ),
    GoRoute(
      name: "artist",
      path: '/artist',
      builder: (context, state) => const ArtistHomePage(),
    ),
    GoRoute(
      name: "listener",
      path: '/listener',
      builder: (context, state) {
        final args = state.extra as ListenerHomePageData;
        return ListenerWidget(arguments: args);
      },
    ),
    GoRoute(
      name: "admin",
      path: '/admin',
      builder: (context, state) => AdminLogin(),
    ),
    GoRoute(
      name: "admin_home",
      path: '/admin_home/:tk',
      builder: (context, state) {
        return AdminHome(tk: state.pathParameters["tk"] as String);
      },
    ),
    GoRoute(
      name: "listener_album",
      path: '/listener/album',
      builder: (context, state) {
        final args = state.extra as Album;
        return AlbumWidget(
          album: args,
        );
      },
    ),
    GoRoute(
      name: "listener_playlist",
      path: '/listener/playlist',
      builder: (context, state) {
        final playlist = state.extra as Playlist;
        return PlaylistWidget(
          playlist: playlist,
        );
      },
    ),
    GoRoute(
      name: "listener_profile",
      path: '/listener/profile',
      builder: (context, state) => const ListenerProfile(),
    ),
    GoRoute(
      name: "listener_new_playlist",
      path: '/listener/new_playlist',
      builder: (context, state) => AddPlaylistWidget(),
    ),
    GoRoute(
      name: "artist_profile",
      path: '/artist/profile',
      builder: (context, state) => const ArtistProfile(),
    ),
    GoRoute(
      name: "artist_album",
      path: '/artist/album',
      builder: (context, state) {
        final args = state.extra as Album;
        return ArtistsAlbumPage(
          album: args,
        );
      },
    ),
  ],
);

void main() {
  runApp(
    MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.listnerTheme,
        routerConfig: _router),
  );
}
