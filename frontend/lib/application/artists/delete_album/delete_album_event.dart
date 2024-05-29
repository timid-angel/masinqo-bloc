abstract class AlbumDeleteEvent {}

class DeleteAlbum extends AlbumDeleteEvent {
  final String albumId;

  DeleteAlbum(this.albumId);
}
