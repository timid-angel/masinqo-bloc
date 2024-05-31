import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_service.dart';
import 'package:mockito/mockito.dart';

class MockListenerFavService extends Mock implements ListenerFavService {
  @override
  Future<List<Album>> getFavorites(String token) => super.noSuchMethod(
        Invocation.method(#getFavorites, [token]),
        returnValue: Future.value([
          Album(
            id: '1',
            title: 'Favorite Album',
            albumArt: 'favorite_album.jpg',
            songs: [],
            description: 'Description for Favorite Album',
            genre: 'Pop',
            date: DateTime.now(),
            artist: 'Artist 1',
          ),
        ]),
        returnValueForMissingStub: Future.value([]),
      );
  @override
  Future<void> addFavorite(String id, String token) => super.noSuchMethod(
        Invocation.method(#addFavorite, [id, token]),
        returnValue: Future.value(None),
        returnValueForMissingStub:
            Future.error(Exception('Failed to add favorite')),
      );

  @override
  Future<void> deleteFavorite(String id, String token) => super.noSuchMethod(
        Invocation.method(#deleteFavorite, [id, token]),
        returnValue: Future.value(null),
        returnValueForMissingStub:
            Future.error(Exception('Failed to delete favorite')),
      );
}

void main() {
  group('ListenerFavService', () {
    test('getFavorites returns a list of albums', () async {
      final mockService = MockListenerFavService();

      when(mockService.getFavorites('token')).thenAnswer((_) async => [
            Album(
              id: '1',
              title: 'Favorite Album',
              albumArt: 'favorite_album.jpg',
              songs: [],
              description: 'Description for Favorite Album',
              genre: 'Pop',
              date: DateTime.now(),
              artist: 'Artist 1',
            ),
          ]);

      final albums = await mockService.getFavorites('token');

      expect(albums.length, 1);
      expect(albums[0].title, 'Favorite Album');
    });

    test('getFavorites handles errors', () async {
      final mockService = MockListenerFavService();

      when(mockService.getFavorites('token'))
          .thenThrow(Exception('Failed to load favorite albums'));

      expect(() => mockService.getFavorites('token'), throwsException);
    });
    test('addFavorite adds a favorite album', () async {
      final mockService = MockListenerFavService();

      when(mockService.addFavorite('1', 'token')).thenAnswer((_) async => None);

      expect(() => mockService.addFavorite('1', 'token'), returnsNormally);
    });

    test('addFavorite handles errors', () async {
      final mockService = MockListenerFavService();

      when(mockService.addFavorite('1', 'token'))
          .thenThrow(Exception('Failed to add favorite'));

      expect(() => mockService.addFavorite('1', 'token'), throwsException);
    });

    test('deleteFavorite handles errors', () async {
      final mockService = MockListenerFavService();

      when(mockService.deleteFavorite('1', 'token'))
          .thenThrow(Exception('Failed to delete favorite'));

      try {
        await mockService.deleteFavorite('1', 'token');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), 'Exception: Failed to delete favorite');
      }
    });

    test('deleteFavorite handles errors', () async {
      final mockService = MockListenerFavService();

      when(mockService.deleteFavorite('1', 'token'))
          .thenThrow(Exception('Failed to delete favorite'));

      expect(() => mockService.deleteFavorite('1', 'token'), throwsException);
    });
  });
}
