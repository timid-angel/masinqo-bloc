import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_datasource.dart';

class MockClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

class MockAdminListenersDatasource extends AdminListenersDatasource {
  MockAdminListenersDatasource(
      {required http.Client client, required String token})
      : super(token: token);

  @override
  Future<http.Response> getListeners() async {
    try {
      return http.Response('{"listeners": []}', 200);
    } catch (e) {
      throw Exception('Listeners Not found');
    }
  }

  @override
  Future<http.Response> deleteListener(String id) async {
    if (id == '1') {
      throw Exception('Listener Not deleted');
    } else {
      return http.Response('{"message": "Listener deleted successfully"}', 200);
    }
  }
}

void main() {
  late AdminListenersDatasource datasource;
  late MockClient mockClient;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });
  setUp(() {
    mockClient = MockClient();
    datasource =
        MockAdminListenersDatasource(client: mockClient, token: 'token');
  });

  group('getListeners', () {
    test('returns a http.Response when the call completes successfully',
        () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"listeners": []}', 200));

      expect(await datasource.getListeners(), isA<http.Response>());
    });

    test('throws an exception when the call completes with an error', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          () async => await datasource.getListeners(),
          throwsA(predicate<Exception>(
              (e) => e.toString() == 'Exception: Listeners Not found')));
    });
  });

  group('deleteListener', () {
    test('returns a http.Response when the call completes successfully',
        () async {
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 200));

      expect(await datasource.deleteListener('2'), isA<http.Response>());
    });

    test('throws an exception when the call completes with an error', () async {
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          () async => await datasource.deleteListener('1'),
          throwsA(predicate<Exception>(
              (e) => e.toString() == 'Exception: Listener Not deleted')));
    });
  });
}
