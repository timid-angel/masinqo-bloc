abstract class AlbumDeleteState {}

class AlbumDeleteInitial extends AlbumDeleteState {}

class AlbumDeleteLoading extends AlbumDeleteState {}

class AlbumDeleteSuccess extends AlbumDeleteState {}

class AlbumDeleteFailure extends AlbumDeleteState {
  final String errorMessage;

  AlbumDeleteFailure(this.errorMessage);
}
