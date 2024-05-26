import 'package:masinqo/temp/models/albums.dart';
import 'package:masinqo/temp/models/playlist.dart';
import 'package:masinqo/temp/models/user.dart';

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
