import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_service.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:mockito/annotations.dart';
import 'listener_fav_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ListenerFavService, ListenerFavRepository])
class Mocks {}

class MockListenerFavCollection extends ListenerFavCollection {
  final ListenerFavRepository repository;

  MockListenerFavCollection(this.repository);

  @override
  Future<List<Album>> getFavorites(String token) async {
    return repository.getFavorites(token);
  }

  @override
  Future<void> addFavorite(String id, String token) async {
    return repository.addFavorite(id, token);
  }

  @override
  Future<void> deleteFavorite(String id, String token) async {
    return repository.deleteFavorite(id, token);
  }
}

void main() {
  group('ListenerFavCollection', () {
    test('getFavorites returns a list of albums', () async {
      final mockRepository = MockListenerFavRepository();
      final listenerFavCollection = MockListenerFavCollection(mockRepository);

      when(mockRepository.getFavorites('valid_token')).thenAnswer((_) async => [
            Album(
              id: '1',
              title: 'Album 1',
              albumArt: 'album1.jpg',
              songs: [],
              description: 'Description for Album 1',
              genre: 'Pop',
              date: DateTime.now(),
              artist: 'Artist 1',
            )
          ]);

      final albums = await listenerFavCollection.getFavorites('valid_token');

      expect(albums, isNotNull);
    });

    test('addFavorite adds a favorite album', () async {
      final mockRepository = MockListenerFavRepository();
      final listenerFavCollection = MockListenerFavCollection(mockRepository);

      await listenerFavCollection.addFavorite('valid_id', 'valid_token');

      verify(mockRepository.addFavorite('valid_id', 'valid_token')).called(1);
    });

    test('deleteFavorite deletes a favorite album', () async {
      final mockRepository = MockListenerFavRepository();
      final listenerFavCollection = MockListenerFavCollection(mockRepository);

      await listenerFavCollection.deleteFavorite('valid_id', 'valid_token');

      verify(mockRepository.deleteFavorite('valid_id', 'valid_token'))
          .called(1);
    });
  });
}
