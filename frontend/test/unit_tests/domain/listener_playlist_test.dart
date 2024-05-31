import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart';
import 'package:mockito/annotations.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'listener_playlist_test.mocks.dart';

@GenerateMocks([ListenerPlaylistService, ListenerPlaylistRepository])
class Mocks {}

class MockListenerPlaylistCollection extends ListenerPlaylistCollection {
  final ListenerPlaylistRepository repository;

  MockListenerPlaylistCollection(this.repository);

  @override
  Future<List<Playlist>> getPlaylists(String token) async {
    return repository.getPlaylists(token);
  }

  @override
  Future<void> addPlaylist(String playlistName, String token) async {
    return repository.addPlaylist(playlistName, token);
  }

  @override
  Future<void> editPlaylist(String id, String name, String token) async {
    return repository.editPlaylist(id, name, token);
  }
}

void main() {
  group('ListenerPlaylistCollection', () {
    test('getPlaylists returns a list of playlists', () async {
      // Arrange
      final mockRepository = MockListenerPlaylistRepository();
      final listenerPlaylistCollection =
          MockListenerPlaylistCollection(mockRepository);

      // Add a stub for getPlaylists
      when(mockRepository.getPlaylists('valid_token')).thenAnswer((_) async => [
            Playlist(
              id: '1',
              name: 'Playlist 1',
              description: 'Description for Playlist 1',
              owner: 'Artist 1',
              creationDate: DateTime.now(),
              songs: [],
            )
          ]);

      final playlists =
          await listenerPlaylistCollection.getPlaylists('valid_token');

      expect(playlists, isNotNull);
    });

    test('addPlaylist adds a playlist', () async {
      final mockRepository = MockListenerPlaylistRepository();
      final listenerPlaylistCollection =
          MockListenerPlaylistCollection(mockRepository);

      await listenerPlaylistCollection.addPlaylist(
          'valid_playlist_name', 'valid_token');

      verify(mockRepository.addPlaylist('valid_playlist_name', 'valid_token'))
          .called(1);
    });

    test('editPlaylist edits a playlist', () async {
      final mockRepository = MockListenerPlaylistRepository();
      final listenerPlaylistCollection =
          MockListenerPlaylistCollection(mockRepository);

      await listenerPlaylistCollection.editPlaylist(
          'valid_id', 'valid_name', 'valid_token');

      verify(mockRepository.editPlaylist(
              'valid_id', 'valid_name', 'valid_token'))
          .called(1);
    });
  });
}
