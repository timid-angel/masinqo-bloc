class Song {
  final String name;
  final String filePath;

  Song({
    required this.name,
    required this.filePath,
  });
}

class AlbumState {
  final String title;
  final String albumArt;
  List<Song> songs;
  final String artist;
  final String description;
  final String genre;
  final DateTime date;
  bool isDeleted;
  String error;
  final String albumId;

  AlbumState({
    required this.title,
    required this.albumArt,
    required this.songs,
    required this.description,
    required this.genre,
    required this.date,
    required this.artist,
    required this.error,
    this.isDeleted = false,
    required this.albumId,
  });
}
