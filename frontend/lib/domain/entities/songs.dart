class Song {
  String name;
  String filePath;
  String albumArt;

  Song({
    required this.name,
    required this.filePath,
    required this.albumArt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final s = Song(
        name: json['name'] ?? '',
        filePath: json['filePath'] ?? '',
        albumArt: json['albumArt'] ?? '');
    return s;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'filePath': filePath,
      'albumArt': albumArt,
    };
  }
}
