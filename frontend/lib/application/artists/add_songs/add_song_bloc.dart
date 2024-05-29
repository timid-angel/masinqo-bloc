import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import './add_songs_event.dart';
import './add_songs_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final ArtistsRepositoryInterface artistsRepository;

  SongBloc({required this.artistsRepository}) : super(SongInitial());

  Stream<SongState> mapEventToState(SongEvent event) async* {
    if (event is AddSongEvent) {
      yield* _mapAddSongEventToState(event);
    }
  }

  Stream<SongState> _mapAddSongEventToState(AddSongEvent event) async* {
    yield SongLoading();

    final createSongDto = event.songDto;

    final Either<Failure, Success> result =
        await artistsRepository.addSong(createSongDto, event.songFilePath);

    yield* result.fold(
      (failure) async* {
        yield SongFailure(failure.message ?? 'An unknown error occurred');
      },
      (success) async* {
        yield const SongSuccess('Song added successfully');
      },
    );
  }
}
