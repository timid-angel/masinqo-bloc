import 'package:masinqo/domain/entities/songs.dart';

class Playlist {
  String? id;
  String name;
  DateTime creationDate;
  String description;
  String owner;
  List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.owner,
    required this.description,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    // print("form json ${json['_id']}");
    return Playlist(
      id: json['_id'] ?? '',
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
      'id': id,
      'name': name,
      'creationDate': creationDate,
      'owner': owner,
      'description': description,
      'songs': songs,
    };
  }
}
