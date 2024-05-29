import 'package:masinqo/domain/entities/albums.dart';

abstract class AlbumState {}

class EmptyAlbum extends AlbumState {}

class LoadedAlbum extends AlbumState {
  final List<Album> albums;

  LoadedAlbum(this.albums);
}

class ErrorAlbum extends AlbumState {
  final String error;

  ErrorAlbum(this.error);
}
