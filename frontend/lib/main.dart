import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_theme_data.dart';
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

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.listnerTheme,
        initialRoute: '/login',
        routes: {
          "/login": (context) => const LoginWidget(),
          "/signup": (context) => const SignupWidget(),
          "/artist": (context) => const ArtistHomePage(),
          "/listener": (context) => const ListenerWidget(),
          "/admin": (context) => const AdminLogin(),
          "/admin/home": (context) => const AdminHome(),
          "/listener/album": (context) => const AlbumWidget(),
          "/listener/playlist": (context) => const PlaylistWidget(),
          "/listener/profile": (context) => const ListenerProfile(),
          "/listener/new_playlist": (context) => AddPlaylistWidget(),
          "/artist/profile": (context) => const ArtistProfile(),
          "/artist/album": (context) => const ArtistsAlbumPage(),
        }),
  );
}
