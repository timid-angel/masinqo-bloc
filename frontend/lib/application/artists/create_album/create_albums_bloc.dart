import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/infrastructure/artists/artists_repository.dart';
import 'create_albums_event.dart';
import 'create_albums_state.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final String token;

  AlbumBloc({
    required this.token,
  }) : super(AlbumInitial()) {
    on<AddAlbumEvent>((event, emit) async {
      emit(AlbumLoading());

      final createAlbumDto = CreateAlbumDTO(
        title: event.title,
        genre: event.genre,
        description: event.description,
        type: event.type,
        albumArt: event.albumArt ?? '',
      );

      final result =
          await ArtistsRepository(token: token).addAlbum(createAlbumDto);

      result.fold(
        (l) => emit(AlbumFailure(l.message)),
        (r) {
          emit(const AlbumSuccess('Album added successfully'));
        },
      );
    });
  }
}
