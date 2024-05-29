import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'create_albums_event.dart';
import 'create_albums_state.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/application/auth/artist_auth_bloc.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ArtistsRepositoryInterface artistsRepository;
  final ArtistAuthBloc artistAuthBloc;

  AlbumBloc({
    required this.artistsRepository,
    required this.artistAuthBloc,
  }) : super(AlbumInitial()) {
    on<AddAlbumEvent>(_onAddAlbumEvent);
  }

  Future<void> _onAddAlbumEvent(
    AddAlbumEvent event,
    Emitter<AlbumState> emit,
  ) async {
    emit(AlbumLoading());

    final token = artistAuthBloc.state.token;

    final createAlbumDto = CreateAlbumDTO(
      title: event.title,
      genre: event.genre,
      description: event.description,
      type: event.type,
      albumArt: event.albumArt ?? '',
      token: token,
    );

    final Either<Failure, Success> result =
        await artistsRepository.addAlbum(createAlbumDto);

    // Handle the result
    result.fold(
      (failure) => emit(AlbumFailure(failure.message ?? 'An unknown error occurred')),
      (success) => emit(const AlbumSuccess('Album added successfully')),
    );
  }
}
