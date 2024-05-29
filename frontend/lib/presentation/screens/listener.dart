import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/domain/listener/listener_album.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/temp/models/route_models/listener_homepage_data.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_tabs.dart';

class ListenerWidget extends StatefulWidget {
  final ListenerHomePageData arguments;

  const ListenerWidget({
    super.key,
    required this.arguments,
  });

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  // late List<Album> albums;
  // late List<Album> favorites;
  // late List<Playlist> playlists;
  late String token;
  // late final ListenerAuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    // albums = widget.arguments.albums;
    // favorites = widget.arguments.favorites;
    // playlists = widget.arguments.playlists;
    token = widget.arguments.token;
    // print("last hope ${token}");
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
                const ListenerHome(
                    // albums: albums,
                    ),
                ListenerFavorites(
                  token: token,
                  // favorites: favorites,
                ),
                ListenerLibrary(
                  token: token,
                  // playlists: playlists,
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
