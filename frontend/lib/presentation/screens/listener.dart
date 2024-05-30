import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/domain/listener/listener_album.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_tabs.dart';

class ListenerWidget extends StatefulWidget {
  final String arguments;

  const ListenerWidget({
    super.key,
    required this.arguments,
  });

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  late String token;
  @override
  void initState() {
    super.initState();
    token = widget.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AlbumBloc(albumCollection: ListenerAlbumCollection()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              PlaylistBloc(playlistRepository: ListenerPlaylistCollection()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              FavoriteBloc(favoriteRepository: ListenerFavCollection()),
        )
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.black,
          endDrawer: const ListenerDrawer(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) {
              return [
                const ListenerAppbar(),
              ];
            },
            body: TabBarView(
              children: [
                ListenerHome(
                  token: token,
                ),
                ListenerFavorites(
                  token: token,
                ),
                ListenerLibrary(
                  token: token,
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigationWidget(),
        ),
      ),
    );
  }
}
