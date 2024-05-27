abstract class AlbumsEvent {}

class GetAlbumsArtist extends AlbumsEvent {}

class RemoveSong extends AlbumsEvent {
  final String songName;
  final String albumId;

  RemoveSong({required this.songName, required this.albumId});
}
