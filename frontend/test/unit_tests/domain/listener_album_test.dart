import 'listener_album_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/listener/listener_album.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ListenerAlbumService, ListenerAlbumRepository])
class Mocks {}

class MockListenerAlbumCollection extends ListenerAlbumCollection {
  final ListenerAlbumRepository repository;

  MockListenerAlbumCollection(this.repository);

  @override
  Future<List<Album>> getAlbums() async {
    return repository.getAlbums();
  }
}

void main() {
  group('ListenerAlbumCollection', () {
    test('getAlbums returns a list of albums', () async {
      final mockRepository = MockListenerAlbumRepository();
      final listenerAlbumCollection =
          MockListenerAlbumCollection(mockRepository);

      final mockAlbums = [
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
      ];

      when(mockRepository.getAlbums()).thenAnswer((_) async => mockAlbums);
      final result = await listenerAlbumCollection.getAlbums();

      expect(result, mockAlbums);
      verify(mockRepository.getAlbums()).called(1);
    });
  });
}
