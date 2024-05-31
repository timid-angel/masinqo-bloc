class Song {
  String name;
  String filePath;
  String albumArt;
  // String albumId;

  Song({
    required this.name,
    required this.filePath,
    required this.albumArt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final s = Song(
      name: json['name'] ?? '',
      filePath: json['filePath'] ?? '',
      albumArt: json['albumArt'] ?? '',
      // albumId: json['album'] ?? '',
    );
    return s;
  }

  Map<String, dynamic> toJson() {
    return {
      // 'album': albumId,
      'name': name,
      'filePath': filePath,
      'albumArt': albumArt,
    };
  }
}
