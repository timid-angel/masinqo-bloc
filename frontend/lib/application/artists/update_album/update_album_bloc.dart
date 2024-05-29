import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/application/artists/update_album/update_album_event.dart';
import 'package:masinqo/application/artists/update_album/update_album_state.dart';


class UpdateAlbumBloc extends Bloc<UpdateAlbumEvent, UpdateAlbumState> {
  final ArtistsRepositoryInterface repository;

  UpdateAlbumBloc(this.repository) : super(UpdateAlbumInitial());

  Stream<UpdateAlbumState> mapEventToState(UpdateAlbumEvent event) async* {
    if (event is UpdateAlbum) {
      yield UpdateAlbumLoading();
      final result = await repository.updateAlbum(event.updateDto);
      if (result.isLeft()) {
        yield UpdateAlbumFailure(result.leftMap((failure) => failure.message) as String);
      } else {
        yield UpdateAlbumSuccess('Album updated successfully' as Success);
      }
    }
  }
}
