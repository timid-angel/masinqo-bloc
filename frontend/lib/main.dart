import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/auth/listener_auth_bloc.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/domain/listener/listener_profile.dart';
import 'package:masinqo/presentation/core/theme/app_theme_data.dart';
import 'package:masinqo/presentation/screens/admin_home.dart';
import 'package:masinqo/presentation/screens/admin_login.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/screens/artist_home.dart';
import 'package:masinqo/presentation/screens/artist_profile.dart';
import 'package:masinqo/presentation/screens/listener.dart';
import 'package:masinqo/presentation/screens/listener_add_playlist.dart';
import 'package:masinqo/presentation/screens/listener_album.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'package:masinqo/presentation/screens/listener_playlist.dart';
import 'package:masinqo/presentation/screens/listener_profile.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:masinqo/presentation/screens/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';

final _router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => LoginWidget(),
    ),
    GoRoute(
      name: "signup",
      path: '/signup',
      builder: (context, state) => SignupWidget(),
    ),
    GoRoute(
      name: "artist",
      path: '/artist:token',
      builder: (context, state) => ArtistHomePage(
        token: state.pathParameters["token"] as String,
      ),
    ),
    GoRoute(
      name: "listener",
      path: '/listener:token',
      builder: (context, state) =>
          ListenerWidget(arguments: state.pathParameters["token"] as String),
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
        final args = state.extra as AlbumNavigationArgument;
        return AlbumWidget(
          album: args.album,
          token: args.token,
          favoriteBloc: args.favoriteBloc,
          playlistBloc: args.playlistBloc,
          playlist: args.playlists,
          profileBloc: args.profileBloc,
        );
      },
    ),
    GoRoute(
      name: "listener_playlist",
      path: '/listener/playlist',
      builder: (context, state) {
        final args = state.extra as PlaylistNavigationArgument;

        return BlocProvider.value(
          value: args.playlistBloc,
          child: PlaylistWidget(
            bloc: args.playlistBloc,
            token: args.token,
            playlist: args.playlist,
            profileBloc: args.profileBloc,
          ),
        );
      },
    ),
    GoRoute(
      name: "listener_profile",
      path: '/listener/profile',
      builder: (context, state) {
        final arg = state.extra as ProfileArgument;
        return ListenerProfile(token: arg.token);
      },
    ),
    GoRoute(
      name: "listener_new_playlist",
      path: '/listener/new_playlist',
      builder: (context, state) {
        final args = state.extra as PlaylistNavigationExtras;

        return BlocProvider.value(
          value: args.playlistBloc,
          child: AddPlaylistWidget(token: args.token),
        );
      },
    ),
    GoRoute(
      name: "artist_profile",
      path: '/artist/profile',
      builder: (context, state) {
        return ArtistProfile(artistHomeBloc: state.extra as ArtistHomeBloc);
      },
    ),
    GoRoute(
      name: "artist_album",
      path: '/artist/album',
      builder: (context, state) {
        return ArtistsAlbumPage(
          blocTransferObject: state.extra as BlocTransferObject,
        );
      },
    ),
  ],
);

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ListenerAuthBloc>(
          create: (context) => ListenerAuthBloc(),
        ),
        BlocProvider<ArtistAuthBloc>(
          create: (context) => ArtistAuthBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ProfileBloc(profileRepository: ListenerProfileCollection()),
        ),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.listnerTheme,
          routerConfig: _router),
    ),
  );
}
