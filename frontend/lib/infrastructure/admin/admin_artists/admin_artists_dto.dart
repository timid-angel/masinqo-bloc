class AdminArtist {
  final String email;
  final String id;
  final String name;
  final bool isBanned;
  final String profilePicture;

  AdminArtist({
    required this.id,
    required this.email,
    required this.name,
    required this.isBanned,
    required this.profilePicture,
  });

  factory AdminArtist.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'name': String name,
        '_id': String id,
        'banned': bool isBanned,
        'profilePictue': String profilePicture,
      } =>
        AdminArtist(
            id: id,
            email: email,
            name: name,
            isBanned: isBanned,
            profilePicture: profilePicture),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class ArtistID {
  final String id;

  ArtistID({required this.id});
}

class ArtistStatus {
  final String id;
  final bool newBannedStatus;

  ArtistStatus({required this.id, required this.newBannedStatus});
}
