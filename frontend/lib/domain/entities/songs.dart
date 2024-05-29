class Song {
  String name;
  String filePath;

  Song({
    required this.name,
    required this.filePath,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    print("inn");
    final s = Song(
      name: json['name'] ?? '',
      filePath: json['filePath'] ?? '',
    );
    print("outtt");
    return s;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'filePath': filePath,
    };
  }
}
