import 'package:test/test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/domain/artists/artists_success.dart';
import 'package:masinqo/domain/artists/artists_failure.dart';
import 'package:masinqo/infrastructure/artists/artists_repository.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class MockArtistsRepository extends Mock implements ArtistsRepository {}

void main() {
  group('addAlbum', () {
    ArtistEntity artistEntity = ArtistEntity(token: 'valid_token');

    test('Should return failure when token is empty', () async {
      final artistEntityWithInvalidToken = ArtistEntity(token: '');
      final result = await artistEntityWithInvalidToken.addAlbum(CreateAlbumDTO(
        title: 'Test Title',
        albumArt: 'Test Album Art',
        genre: 'Test Genre',
        description: 'Test Description',
        type: 'Test Type',
      ));
      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Invalid token'),
      );
    });

    test('Should return failure when album title is empty', () async {
      final result = await artistEntity.addAlbum(CreateAlbumDTO(
          title: '',
          type: 'Album',
          description: 'Test Description',
          albumArt: 'path/to/art.jpg',
          genre: 'Pop'));
      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Title too short'),
      );
    });

    test('Should return failure when album art is missing', () async {
      final result = await artistEntity.addAlbum(CreateAlbumDTO(
          title: 'Test Album',
          type: 'Album',
          description: 'Test Description',
          albumArt: '',
          genre: 'Pop'));

      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Album must have an image'),
      );
    });
    test('Should return failure when genre is empty', () async {
      final result = await artistEntity.addAlbum(CreateAlbumDTO(
          title: 'Test Album',
          type: 'Album',
          description: 'Test Description',
          albumArt: 'path/to/art.jpg',
          genre: ''));
      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Genre can not be empty'),
      );
    });
  });

  Future<Either<ArtistEntityFailure, ArtistEntitySuccess>> addSong(
      CreateSongDTO songDto, String songFilePath) async {
    if (songFilePath.isEmpty) {
      return Left(ArtistEntityFailure(message: "Song must have an audio file"));
    }

    final List<String> extensions = ["png", "jpg", "jpeg"];
    if (extensions.contains(songFilePath.split(".").last)) {
      return Left(ArtistEntityFailure(message: "Song must have an audio file"));
    }

    if (songDto.songName.isEmpty) {
      return Left(ArtistEntityFailure(message: "Song must have a name"));
    }

    return Right(ArtistEntitySuccess());
  }

  group('addSong', () {
    test('should return failure when song file path is empty', () async {
      final CreateSongDTO songDto =
          CreateSongDTO(songName: "Test Song", albumId: 'album-id');
      const String songFilePath = "";

      final result = await addSong(songDto, songFilePath);
      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Song must have an audio file'),
      );
    });

    test('should return failure when song file path has an invalid extension',
        () async {
      final CreateSongDTO songDto =
          CreateSongDTO(songName: "Test Song", albumId: 'album-id');
      const String songFilePath = "path/to/song.png";

      final result = await addSong(songDto, songFilePath);

      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Song must have an audio file'),
      );
    });

    test('should return failure when song name is empty', () async {
      final CreateSongDTO songDto =
          CreateSongDTO(songName: "", albumId: 'album-id');
      const String songFilePath = "path/to/song.mp3";

      final result = await addSong(songDto, songFilePath);
      expect(
        result.fold((l) => l.message, (r) => null),
        equals('Song must have a name'),
      );
    });

    test('should return success when all inputs are valid', () async {
      final CreateSongDTO songDto =
          CreateSongDTO(songName: "Test Song", albumId: 'album-id');
      const String songFilePath = "path/to/song.mp3";

      final result = await addSong(songDto, songFilePath);
      expect(
        result.fold(
            (l) => fail('Expected success, but got failure $l'), (r) => r),
        isA<ArtistEntitySuccess>(),
      );
    });
  });
}
