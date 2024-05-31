import 'dart:core';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart';
import 'package:mockito/mockito.dart';

class MockListenerPlaylistService extends Mock
    implements ListenerPlaylistService {
  @override
  Future<List<Playlist>> getPlaylists(String token) => super.noSuchMethod(
        Invocation.method(#getPlaylists, [token]),
        returnValue: Future.value([
          Playlist(
            id: '1',
            creationDate: DateTime.now(),
            owner: 'Artist 1',
            description: 'Description for Playlist 1',
            name: 'Playlist 1',
            songs: [],
          ),
          Playlist(
            id: '2',
            creationDate: DateTime.now(),
            owner: 'Artist 2',
            description: 'Description for Playlist 1',
            name: 'Playlist 2',
            songs: [],
          )
        ]),
        returnValueForMissingStub: Future.value([]),
      );

  @override
  Future<void> addPlaylist(String name, String token) => super.noSuchMethod(
        Invocation.method(#addPlaylist, [name, token]),
        returnValue: Future.value(0),
        returnValueForMissingStub:
            Future.error(Exception('Failed to add playlist')),
      );

  @override
  Future<void> editPlaylist(String id, String name, String token) =>
      super.noSuchMethod(
        Invocation.method(#editPlaylist, [id, name, token]),
        returnValue: Future.value(null),
        returnValueForMissingStub:
            Future.error(Exception('Failed to edit playlist')),
      );
}

void main() {
  group('ListenerPlaylistService', () {
    test('getPlaylists returns a list of playlists', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.getPlaylists('token')).thenAnswer((_) async => [
            Playlist(
              id: '1',
              creationDate: DateTime.now(),
              owner: 'Artist 1',
              description: 'Description for Playlist 1',
              name: 'Playlist 1',
              songs: [],
            ),
            Playlist(
              id: '2',
              creationDate: DateTime.now(),
              owner: 'Artist 2',
              description: 'Description for Playlist 1',
              name: 'Playlist 2',
              songs: [],
            ),
          ]);

      final playlists = await mockService.getPlaylists('token');

      expect(playlists.length, 2);
      expect(playlists[0].name, 'Playlist 1');
      expect(playlists[1].name, 'Playlist 2');
    });

    test('getPlaylists handles errors', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.getPlaylists('token'))
          .thenThrow(Exception('Failed to load playlists'));

      expect(() => mockService.getPlaylists('token'), throwsException);
    });

    test('addPlaylist adds a playlist', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.addPlaylist('Playlist 3', 'token'))
          .thenAnswer((_) async => null);

      expect(() => mockService.addPlaylist('Playlist 3', 'token'),
          returnsNormally);
    });

    test('addPlaylist handles errors', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.addPlaylist('Playlist 3', 'token'))
          .thenThrow(Exception('Failed to add playlist'));

      expect(() => mockService.addPlaylist('Playlist 3', 'token'),
          throwsException);
    });

    test('editPlaylist edits a playlist', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.editPlaylist('1', 'Playlist 1 edited', 'token'))
          .thenAnswer((_) async => 0);

      expect(() => mockService.editPlaylist('1', 'Playlist 1 edited', 'token'),
          returnsNormally);
    });

    test('editPlaylist handles errors', () async {
      final mockService = MockListenerPlaylistService();

      when(mockService.editPlaylist('1', 'Playlist 1 edited', 'token'))
          .thenThrow(Exception('Failed to edit playlist'));

      expect(() => mockService.editPlaylist('1', 'Playlist 1 edited', 'token'),
          throwsException);
    });
  });
}
