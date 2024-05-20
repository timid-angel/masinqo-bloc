import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/user.dart';

class Listener extends User {
  List<Playlist> playlists;
  List<Album> favorites;

  Listener({
    required super.name,
    required super.email,
    required super.password,
    required this.playlists,
    required this.favorites,
  });
}
