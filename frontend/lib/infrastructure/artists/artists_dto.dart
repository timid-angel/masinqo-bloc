class UpdateAlbumDTO {
  final String title;
  final String genre;
  final String description;
  final String albumId;

  UpdateAlbumDTO({
    required this.albumId,
    required this.title,
    required this.genre,
    required this.description,
  });
}

class CreateAlbumDTO {
  final String title;
  final String genre;
  final String description;
  final String type;
  final String albumArt;

  CreateAlbumDTO({
    required this.type,
    required this.title,
    required this.genre,
    required this.description,
    required this.albumArt,
  });
}

class CreateSongDTO {
  final String songName;
  final String albumId;

  CreateSongDTO({required this.songName, required this.albumId});
}