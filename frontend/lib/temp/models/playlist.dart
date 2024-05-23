import 'package:masinqo/temp/models/listener.dart';
import 'package:masinqo/temp/models/songs.dart';

class Playlist {
  String name;
  DateTime creationDate;
  String description;
  Listener owner;
  List<Song> songs;

  Playlist({
    required this.name,
    required this.creationDate,
    required this.owner,
    required this.description,
    required this.songs,
  });
}
