import 'dart:core';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_service.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_repository.dart';
import 'package:mockito/mockito.dart';

class MockListenerAlbumService extends Mock implements ListenerAlbumService {
  @override
  Future<List<Album>> getAlbums() => super.noSuchMethod(
        Invocation.method(#getAlbums, []),
        returnValue: Future.value([
          Album(
            id: '1',
            title: 'Album 1',
            albumArt: 'album1.jpg',
            songs: [],
            description: 'Description for Album 1',
            genre: 'Pop',
            date: DateTime.now(),
            artist: 'Artist 1',
          ),
          Album(
            id: '2',
            title: 'Album 2',
            albumArt: 'album2.jpg',
            songs: [],
            description: 'Description for Album 2',
            genre: 'Rock',
            date: DateTime.now(),
            artist: 'Artist 2',
          )
        ]),
        returnValueForMissingStub: Future.value([]),
      );
}

void main() {
  group('ListenerAlbumRepository', () {
    test('getAlbums returns a list of albums', () async {
      final mockService = MockListenerAlbumService();
      final repository = ListenerAlbumRepository(mockService);

      when(mockService.getAlbums()).thenAnswer((_) async => [
            Album(
              id: '1',
              title: 'Album 1',
              albumArt: 'album1.jpg',
              songs: [],
              description: 'Description for Album 1',
              genre: 'Pop',
              date: DateTime.now(),
              artist: 'Artist 1',
            ),
            Album(
              id: '2',
              title: 'Album 2',
              albumArt: 'album2.jpg',
              songs: [],
              description: 'Description for Album 2',
              genre: 'Rock',
              date: DateTime.now(),
              artist: 'Artist 2',
            ),
          ]);

      final albums = await repository.getAlbums();

      expect(albums.length, 2);
      expect(albums[0].title, 'Album 1');
      expect(albums[1].title, 'Album 2');
    });

    test('getAlbums handles errors', () async {
      final mockService = MockListenerAlbumService();
      final repository = ListenerAlbumRepository(mockService);

      when(mockService.getAlbums())
          .thenThrow(Exception('Failed to load albums'));

      expect(() => repository.getAlbums(), throwsException);
    });
  });
}
