import 'package:masinqo/infrastructure/artists/artists_dto.dart';

abstract class AlbumEvent {}

class AddSongEvent extends AlbumEvent {
  final CreateSongDTO songDto;
  final String songFilePath;

  AddSongEvent({
    required this.songDto,
    required this.songFilePath,
  });
}

class DeleteAlbumEvent extends AlbumEvent {
  final String albumId;

  DeleteAlbumEvent({required this.albumId});
}

class DeleteSongEvent extends AlbumEvent {
  final String songName;
  final String albumId;

  DeleteSongEvent({required this.songName, required this.albumId});
}

class AlbumUpdateEvent extends AlbumEvent {
  final UpdateAlbumDTO updateAlbumDTO;

  AlbumUpdateEvent({required this.updateAlbumDTO});
}
