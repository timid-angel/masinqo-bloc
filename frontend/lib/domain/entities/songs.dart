class Song {
  String name;
  String filePath;

  Song({
    required this.name,
    required this.filePath,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      name: json['name'],
      filePath: json['filePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'filePath': filePath,
    };
  }
}
