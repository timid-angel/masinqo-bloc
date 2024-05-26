import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/admin/admin_failure.dart';
import 'package:masinqo/domain/admin/admin_success.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';

class AdminListenerCollection {
  late List<AdminListener> listeners;
  final String token;

  AdminListenerCollection({required this.token});
  Future<Either<AdminFailure, GetListenersSuccess>> getListeners() async {
    if (token.isEmpty) {
      return Left(AdminFailure(message: "Invalid token"));
    }

    final res = await AdminListenersRepository(token: token).getListeners();
    res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(GetListenersSuccess(
          listeners: r.listeners
              .map((a) => AdminListener(id: a.id, email: a.email, name: a.name))
              .toList()));
    });

    return Left(AdminFailure(message: "Unknown Error"));
  }

  Future<Either<AdminFailure, AdminSuccess>> deleteListener(String id) async {
    if (token.isEmpty) {
      return Left(AdminFailure(message: "Invalid token"));
    }
    final res = await AdminListenersRepository(token: token)
        .deleteListener(ListenerID(id: id));

    res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(AdminSuccess());
    });

    return Left(AdminFailure(message: "Unknown Error"));
  }
}

class AdminListener {
  final String email;
  final String id;
  final String name;

  AdminListener({
    required this.id,
    required this.email,
    required this.name,
  });
}
