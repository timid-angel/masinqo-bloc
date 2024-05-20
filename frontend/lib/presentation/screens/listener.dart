import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/route_models/listener_homepage_data.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_tabs.dart';

class ListenerWidget extends StatefulWidget {
  const ListenerWidget({
    super.key,
  });

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  late List<Album> albums;
  late List<Album> favorites;
  late List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    final local =
        ModalRoute.of(context)!.settings.arguments as ListenerHomePageData;
    albums = local.albums;
    favorites = local.favorites;
    playlists = local.playlists;

    return DefaultTabController(
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
                albums: albums,
              ),
              ListenerFavorites(
                favorites: favorites,
              ),
              ListenerLibrary(
                playlists: playlists,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }
}
