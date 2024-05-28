import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/application/artists/delete_album/delete_album_state.dart';
import 'package:masinqo/application/artists/delete_album/delete_album_event.dart';

class AlbumDeleteBloc extends Bloc<AlbumDeleteEvent, AlbumDeleteState> {
  final ArtistsRepositoryInterface repository;

  AlbumDeleteBloc({required this.repository}) : super(AlbumDeleteInitial());


  Stream<AlbumDeleteState> mapEventToState(AlbumDeleteEvent event) async* {
    if (event is DeleteAlbum) {
      yield AlbumDeleteLoading();

      final result = await repository.deleteAlbum(event.albumId);

      yield* result.fold(
        (failure) async* {
          yield AlbumDeleteFailure(failure.message ?? 'Unknown error occurred');
        },
        (_) async* {
          yield AlbumDeleteSuccess();
        },
      );
    }
  }
}
