import 'package:masinqo/models/artists.dart';
import 'package:masinqo/models/songs.dart';

class Album {
  String title;
  String description;
  String genre;
  DateTime date;
  String albumArt;
  Artist artist;
  List<Song> songs;

  Album({
    required this.title,
    required this.description,
    required this.genre,
    required this.date,
    required this.albumArt,
    required this.artist,
    required this.songs,
  });
}
