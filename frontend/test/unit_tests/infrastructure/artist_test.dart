import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/infrastructure/artists/artists_success.dart';
import 'package:masinqo/infrastructure/artists/artists_failure.dart';
import 'package:mockito/mockito.dart';

class MockArtistsRepository extends Mock implements ArtistsRepositoryInterface {
  @override
  Future<Either<Failure, Success>> addAlbum(CreateAlbumDTO album) =>
      super.noSuchMethod(
        Invocation.method(#addAlbum, [album]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );

  @override
  Future<Either<Failure, Success>> addSong(
          CreateSongDTO songDto, String songFilePath) =>
      super.noSuchMethod(
        Invocation.method(#addSong, [songDto, songFilePath]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );

  @override
  Future<Either<Failure, Success>> deleteAlbum(String albumId) =>
      super.noSuchMethod(
        Invocation.method(#deleteAlbum, [albumId]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );

  @override
  Future<Either<Failure, GetAlbumsSuccess>> getAlbums() => super.noSuchMethod(
        Invocation.method(#getAlbums, []),
        returnValue: Future.value(
            Right<Failure, GetAlbumsSuccess>(GetAlbumsSuccess(albums: []))),
        returnValueForMissingStub: Future.value(
            Right<Failure, GetAlbumsSuccess>(GetAlbumsSuccess(albums: []))),
      );

  @override
  Future<Either<Failure, GetSongsSuccess>> getSongs(String albumId) =>
      super.noSuchMethod(
        Invocation.method(#getSongs, [albumId]),
        returnValue: Future.value(
            Right<Failure, GetSongsSuccess>(GetSongsSuccess(songs: []))),
        returnValueForMissingStub: Future.value(
            Right<Failure, GetSongsSuccess>(GetSongsSuccess(songs: []))),
      );

  @override
  Future<Either<Failure, Success>> removeSong(
          String albumId, String songName) =>
      super.noSuchMethod(
        Invocation.method(#removeSong, [albumId, songName]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );

  @override
  Future<Either<Failure, Success>> updateAlbum(UpdateAlbumDTO updateDto) =>
      super.noSuchMethod(
        Invocation.method(#updateAlbum, [updateDto]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );

  @override
  Future<Either<Failure, Success>> updateInformation(
          UpdateArtistInformatioDTO artist) =>
      super.noSuchMethod(
        Invocation.method(#updateInformation, [artist]),
        returnValue: Future.value(Right<Failure, Success>(ArtistsSuccess())),
        returnValueForMissingStub:
            Future.value(Right<Failure, Success>(ArtistsSuccess())),
      );
}

void main() {
  MockArtistsRepository mockArtistsRepository = MockArtistsRepository();

  final testAlbumDto = CreateAlbumDTO(
    title: 'Test Title',
    albumArt: 'Test Album Art',
    genre: 'Test Genre',
    description: 'Test Description',
    type: 'Test Type',
  );

  test('should add album when fields are not empty', () async {
    when(mockArtistsRepository.addAlbum(testAlbumDto)).thenAnswer(
        (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result = await mockArtistsRepository.addAlbum(testAlbumDto);

    verify(mockArtistsRepository.addAlbum(testAlbumDto));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });

  final testSongDto = CreateSongDTO(albumId: 'album-id', songName: 'Test Song');
  test('should add song when fields are not empty', () async {
    when(mockArtistsRepository.addSong(testSongDto, 'song-file-path'))
        .thenAnswer(
            (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result =
        await mockArtistsRepository.addSong(testSongDto, 'song-file-path');

    verify(mockArtistsRepository.addSong(testSongDto, 'song-file-path'));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });

  const albumId = 'album-id';
  test('should delete album when albumId is valid', () async {
    when(mockArtistsRepository.deleteAlbum(albumId)).thenAnswer(
        (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result = await mockArtistsRepository.deleteAlbum(albumId);

    verify(mockArtistsRepository.deleteAlbum(albumId));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });

  test('should get albums successfully', () async {
    when(mockArtistsRepository.getAlbums()).thenAnswer((_) async =>
        Right<ArtistFailure, GetAlbumsSuccess>(GetAlbumsSuccess(albums: [])));

    final result = await mockArtistsRepository.getAlbums();

    verify(mockArtistsRepository.getAlbums());
    expect(
        result,
        isA<Right<ArtistFailure, GetAlbumsSuccess>>()
            .having((r) => r.value, 'value', isA<GetAlbumsSuccess>()));
  });

  test('should get songs successfully', () async {
    when(mockArtistsRepository.getSongs(albumId)).thenAnswer((_) async =>
        Right<ArtistFailure, GetSongsSuccess>(GetSongsSuccess(songs: [])));

    final result = await mockArtistsRepository.getSongs(albumId);

    verify(mockArtistsRepository.getSongs(albumId));
    expect(
        result,
        isA<Right<ArtistFailure, GetSongsSuccess>>()
            .having((r) => r.value, 'value', isA<GetSongsSuccess>()));
  });

  const songName = 'song-name';
  test('should remove song when albumId and songName are valid', () async {
    when(mockArtistsRepository.removeSong(albumId, songName)).thenAnswer(
        (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result = await mockArtistsRepository.removeSong(albumId, songName);

    verify(mockArtistsRepository.removeSong(albumId, songName));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });

  final updateDto = UpdateAlbumDTO(
    albumId: 'album-id',
    title: 'Updated Title',
    genre: 'Updated Genre',
    description: 'Updated Description',
  );

  test('should update album when fields are valid', () async {
    when(mockArtistsRepository.updateAlbum(updateDto)).thenAnswer(
        (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result = await mockArtistsRepository.updateAlbum(updateDto);

    verify(mockArtistsRepository.updateAlbum(updateDto));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });

  final updateInfoDto = UpdateArtistInformatioDTO(
    'path/to/profile/picture',
    email: 'test@example.com',
    name: 'Test Artist',
    password: 'password123',
  );
  test('should update artist information when fields are valid', () async {
    when(mockArtistsRepository.updateInformation(updateInfoDto)).thenAnswer(
        (_) async => Right<ArtistFailure, Success>(ArtistsSuccess()));

    final result = await mockArtistsRepository.updateInformation(updateInfoDto);

    verify(mockArtistsRepository.updateInformation(updateInfoDto));
    expect(
        result,
        isA<Right<ArtistFailure, Success>>()
            .having((r) => r.value, 'value', isA<ArtistsSuccess>()));
  });
}
