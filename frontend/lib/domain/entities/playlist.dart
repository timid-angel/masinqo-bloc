import 'package:masinqo/domain/entities/songs.dart';

class Playlist {
  String name;
  DateTime creationDate;
  String description;
  String owner;
  List<Song> songs;

  Playlist({
    required this.name,
    required this.creationDate,
    required this.owner,
    required this.description,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      name: json['name'] ?? '',
      creationDate:
          DateTime.parse(json['creationDate'] ?? DateTime.now().toString()),
      owner: json['owner'] ?? '',
      description: json['description'] ?? '',
      songs: (json['songs'] as List<dynamic>)
          .map((songJson) => Song.fromJson(songJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'creationDate': creationDate,
      'owner': owner,
      'description': description,
      'songs': songs,
    };
  }
}
