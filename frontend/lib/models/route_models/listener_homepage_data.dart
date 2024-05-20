import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/playlist.dart';

class ListenerHomePageData {
  ListenerHomePageData(
      {required this.albums, required this.favorites, required this.playlists});

  final List<Album> albums;
  final List<Album> favorites;
  final List<Playlist> playlists;
}
