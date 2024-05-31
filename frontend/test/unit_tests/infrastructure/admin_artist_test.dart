import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_datasource.dart';

class MockClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

class MockAdminArtistsDatasource extends AdminArtistsDatasource {
  MockAdminArtistsDatasource(
      {required http.Client client, required String token})
      : super(token: token);

  @override
  Future<http.Response> getArtists() async {
    try {
      return http.Response('{"artists": []}', 200);
    } catch (e) {
      throw Exception('Artists Not found');
    }
  }

  @override
  Future<http.Response> deleteArtist(String id) async {
    if (id == '1') {
      throw Exception('Artist Not deleted');
    } else {
      return http.Response('{"message": "Artist deleted successfully"}', 200);
    }
  }

  @override
  Future<http.Response> changeStatus(String status, String id) async {
    if (status == 'activate' && id == '1') {
      throw Exception('Not Found');
    } else {
      return http.Response('{"message": "Status updated successfully"}', 200);
    }
  }
}

void main() {
  late AdminArtistsDatasource datasource;
  late MockClient mockClient;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });
  setUp(() {
    mockClient = MockClient();
    datasource = MockAdminArtistsDatasource(client: mockClient, token: 'token');
  });

  group('getArtists', () {
    test('returns a http.Response when the call completes successfully',
        () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"artists": []}', 200));

      expect(await datasource.getArtists(), isA<http.Response>());
    });

    test('throws an exception when the call completes with an error', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          () async => await datasource.getArtists(),
          throwsA(predicate<Exception>(
              (e) => e.toString() == 'Exception: Artists Not found')));
    });
  });

  group('deleteArtist', () {
    test('returns a http.Response when the call completes successfully',
        () async {
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 200));

      expect(await datasource.deleteArtist('2'), isA<http.Response>());
    });

    test('throws an exception when the call completes with an error', () async {
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          () async => await datasource.deleteArtist('1'),
          throwsA(predicate<Exception>(
              (e) => e.toString() == 'Exception: Artist Not deleted')));
    });
  });

  group('changeStatus', () {
    test('returns a http.Response when the call completes successfully',
        () async {
      when(() => mockClient.patch(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 200));

      expect(await datasource.changeStatus('deactivate', '2'),
          isA<http.Response>());
    });

    test('throws an exception when the call completes with an error', () async {
      when(() => mockClient.patch(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          () async => await datasource.changeStatus('activate', '1'),
          throwsA(predicate<Exception>(
              (e) => e.toString() == 'Exception: Not Found')));
    });
  });
}
