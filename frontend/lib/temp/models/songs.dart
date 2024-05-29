import 'package:masinqo/temp/models/albums.dart';

class Song {
  String name;
  String filePath;
  Album album;
  Song({
    required this.name,
    required this.filePath,
    required this.album,
  });
}

class MockSong {
  String name;
  String filePath;

  MockSong({
    required this.name,
    required this.filePath,
  });
}
