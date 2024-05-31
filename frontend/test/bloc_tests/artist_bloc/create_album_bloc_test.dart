import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/artists/create_album/create_albums_bloc.dart';
import 'package:masinqo/application/artists/create_album/create_albums_event.dart';
import 'package:masinqo/application/artists/create_album/create_albums_state.dart';
import 'package:masinqo/infrastructure/artists/artists_failure.dart';
import 'package:masinqo/infrastructure/artists/artists_repository.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/infrastructure/artists/artists_success.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockArtistsRepository extends Mock implements ArtistsRepository {}

void main() {
  late MockArtistsRepository mockArtistsRepository;
  late AlbumBloc albumBloc;
  const token = 'test_token';

  setUp(() {
    mockArtistsRepository = MockArtistsRepository();
    albumBloc = AlbumBloc(token: token);
  });

  tearDown(() {
    albumBloc.close();
  });

  group('AlbumBloc', () {
    const albumTitle = 'Test Album';
    const albumGenre = 'Test Genre';
    const albumDescription = 'Test Description';
    const albumType = 'Test Type';
    const albumArt = 'Test Album Art';

    final createAlbumDto = CreateAlbumDTO(
      title: albumTitle,
      genre: albumGenre,
      description: albumDescription,
      type: albumType,
      albumArt: albumArt,
    );

    test('initial state is AlbumInitial', () {
      expect(albumBloc.state, AlbumInitial());
    });

    blocTest<AlbumBloc, AlbumState>(
      'emits [AlbumLoading, AlbumSuccess] when adding album succeeds',
      build: () {
        when(() => mockArtistsRepository.addAlbum(any())).thenAnswer(
          (_) async => Right(unit as AddAlbumSuccess),
        );
        return AlbumBloc(token: token);
      },
      act: (bloc) => bloc.add(const AddAlbumEvent(
        title: albumTitle,
        genre: albumGenre,
        description: albumDescription,
        type: albumType,
        albumArt: albumArt,
      )),
      expect: () => [
        AlbumLoading(),
        const AlbumSuccess('Album added successfully'),
      ],
      verify: (_) {
        verify(() => mockArtistsRepository.addAlbum(createAlbumDto)).called(1);
      },
    );

    blocTest<AlbumBloc, AlbumState>(
      'emits [AlbumLoading, AlbumFailure] when adding album fails',
      build: () {
        when(() => mockArtistsRepository.addAlbum(any())).thenAnswer(
          (_) async => Left(const AlbumFailure('Failed to add album') as ArtistFailure),
        );
        return AlbumBloc(token: token);
      },
      act: (bloc) => bloc.add(const AddAlbumEvent(
        title: albumTitle,
        genre: albumGenre,
        description: albumDescription,
        type: albumType,
        albumArt: albumArt,
      )),
      expect: () => [
        AlbumLoading(),
        const AlbumFailure('Failed to add album'),
      ],
      verify: (_) {
        verify(() => mockArtistsRepository.addAlbum(createAlbumDto)).called(1);
      },
    );
  });
}
