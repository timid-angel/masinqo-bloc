import 'package:masinqo/domain/entities/songs.dart';

class Album {
  final String title;
  final String albumArt;
  final List<Song> songs;
  final String artist;
  final String description;
  final String genre;
  final DateTime date;

  Album({
    required this.title,
    required this.albumArt,
    required this.songs,
    required this.description,
    required this.genre,
    required this.date,
    required this.artist,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['title'] ?? '',
      albumArt: json['albumArt'] ?? '',
      description: json['description'],
      genre: json['genre'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      artist: json['artist'],
      songs: (json['songs'] as List<dynamic>)
          .map((songJson) => Song.fromJson(songJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'albumArt': albumArt,
      'description': description,
      'genre': genre,
      'date': date,
      'artist': artist,
      'songs': songs,
    };
  }
}
