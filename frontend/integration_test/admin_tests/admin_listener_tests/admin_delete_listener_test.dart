
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_datasource.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_success.dart';
import 'package:masinqo/presentation/widgets/admin_listener_mgt.dart';
import 'package:mocktail/mocktail.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_dto.dart' as dto;


class MockAdminListenersRepository extends Mock implements AdminListenersRepository {}

class MockAdminListenersDataSource extends Mock implements AdminListenersDatasource {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockAdminListenersRepository mockRepository;
  late ListenerBloc listenerBloc;

  setUp(() {
    mockRepository = MockAdminListenersRepository();
    listenerBloc = ListenerBloc(mockRepository as String);  
  });

  group('Admin Delete Listener Test', () {
     testWidgets('Listener is deleted and UI updates', (WidgetTester tester) async {
      final fakeListeners = [
        dto.AdminListener(id: '1', email: 'listener1@example.com', name: 'listener 1'),
                dto.AdminListener(id: '2', email: 'listener2@example.com', name: 'Listener 2'),
      ];

      when(() => mockRepository.getListeners()).thenAnswer((_) async => Right(ListenerFetchSuccess(listeners: fakeListeners)));
      when(() => mockRepository.deleteListener('1' as dto.ListenerID)).thenAnswer((_) async => Right(ListenerDeleteSuccess()));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ListenerBloc>(
            create: (context) => listenerBloc,
            child: const AdminListenerMGT(),
          ),
        ),
      );

      listenerBloc.add(GetListeners(token: ''));

      await tester.pumpAndSettle();

      expect(find.text('Listener 1'), findsOneWidget);

      listenerBloc.add(DeleteListener(listenerId: '1', token: ''));

      await tester.pumpAndSettle();

      expect(find.text('Listener 1'), findsNothing);
    });
  });
}