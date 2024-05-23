import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_failures.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_success.dart';

abstract class AdminListenerRepository {
  Future<Either<ListenerFetchFailure, ListenerFetchSuccess>> getListeners();
  Future<Either<ListenerDeleteFailure, ListenerDeleteSuccess>> deleteListener(
      ListenerID listener);
}
