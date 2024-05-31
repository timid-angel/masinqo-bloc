import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';
import 'package:mockito/mockito.dart';

class MockAdminListenersRepository extends Mock
    implements AdminListenersRepository {}

void main() {
  MockAdminListenersRepository mockAdminListenersRepository =
      MockAdminListenersRepository();
  AdminListenerCollection adminListenerCollection =
      AdminListenerCollection(adminListenersRepo: mockAdminListenersRepository);

  group('getListeners', () {
    test('should return AdminFailure when token is empty', () async {
      when(mockAdminListenersRepository.token).thenReturn('');

      final result = await adminListenerCollection.getListeners();

      expect(
          result.fold((l) => l.message, (r) => null), equals("Invalid token"));
    });

    // test('should return AdminFailure when repository returns an error',
    //     () async {
    //   when(mockAdminListenersRepository.token).thenReturn('token');
    //   when(mockAdminListenersRepository.getListeners()).thenAnswer(
    //       (_) async => Left(ListenerFetchFailure(message: "Error message")));

    //   final result = await adminListenerCollection.getListeners();

    //   expect(
    //       result.fold((l) => l.message, (r) => null), equals("Error message"));
    // });

    // test(
    //     'should return GetListenersSuccess when repository returns a list of listeners',
    //     () async {
    //   when(mockAdminListenersRepository.token).thenReturn('token');
    //   when(mockAdminListenersRepository.getListeners())
    //       .thenAnswer((_) async => Right(ListenerFetchSuccess(listeners: [])));

    //   final result = await adminListenerCollection.getListeners();

    //   expect(
    //     result,
    //     isA<Left<AdminFailure, dynamic>>().having(
    //       (left) => left.fold((l) => l.message, (r) => 'Not an error'),
    //       'Error message',
    //       equals('Invalid token'),
    //     ),
    //   );
    // });
  });

  // group('deleteListener', () {
  //   test('should return AdminFailure when token is empty', () async {
  //     when(mockAdminListenersRepository.token).thenReturn('');

  //     final result = await adminListenerCollection.deleteListener('id');

  //     expect(result, Left(AdminFailure(message: "Invalid token")));
  //   });

  //   test('should return AdminFailure when repository returns an error',
  //       () async {
  //     when(mockAdminListenersRepository.token).thenReturn('token');
  //     when(mockAdminListenersRepository.deleteListener(ListenerID(id: 'id')))
  //         .thenAnswer((_) async =>
  //             Left(ListenerDeleteFailure(message: "Error message")));

  //     final result = await adminListenerCollection.deleteListener('id');

  //     expect(result, Left(AdminFailure(message: "Error message")));
  //   });

  //   test(
  //       'should return AdminSuccess when repository successfully deletes a listener',
  //       () async {
  //     when(mockAdminListenersRepository.token).thenReturn('token');
  //     when(mockAdminListenersRepository.deleteListener(ListenerID(id: 'id')))
  //         .thenAnswer((_) async => Right(ListenerDeleteSuccess()));

  //     final result = await adminListenerCollection.deleteListener('id');

  //     expect(result, Right(AdminSuccess()));
  //   });
  // });
}
