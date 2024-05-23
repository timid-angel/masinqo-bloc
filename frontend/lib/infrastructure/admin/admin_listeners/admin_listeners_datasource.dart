import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listener_failures.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_success.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class AdminListenerDataSource implements AdminListenerRepository {
  final String url = Domain.url;
  final String token;

  AdminListenerDataSource({required this.token});

  @override
  Future<Either<ListenerFetchFailure, ListenerFetchSuccess>>
      getListeners() async {
    http.Response response =
        await http.get(Uri.parse("$url/listener"), headers: {
      "Cookie": token,
    });

    if (!(response.statusCode == 200)) {
      final Map res = jsonDecode(response.body);
      return Left(ListenerFetchFailure(message: res["message"]));
    }

    List<AdminListener> res = [];
    List listeners = jsonDecode(response.body);
    for (int i = 0; i < listeners.length; i++) {
      res.add(AdminListener(
          id: listeners[i]["_id"],
          email: listeners[i]["email"],
          name: listeners[i]["name"]));
    }

    return Right(ListenerFetchSuccess(listeners: res));
  }

  @override
  Future<Either<ListenerDeleteFailure, ListenerDeleteSuccess>> deleteListener(
      ListenerID listener) async {
    http.Response response =
        await http.delete(Uri.parse("$url/listener/${listener.id}"), headers: {
      "Cookie": token,
    });

    if (!(response.statusCode == 200)) {
      final Map res = jsonDecode(response.body);
      return Left(ListenerDeleteFailure(message: res["message"]));
    }

    return Right(ListenerDeleteSuccess());
  }
}

// void main() async {
//   AdminListenerDataSource adminListenerDS = AdminListenerDataSource(
//       token:
//           'accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NDkzMzQ4YjUyOTkyM2I5YmI5ZGFkNSIsInJvbGUiOjAsImlhdCI6MTcxNjQ2MzgxOCwiZXhwIjoxNzE2NTUwMjE4fQ.Strn3-PIJ9DeA74r0mb4BTtilYI07tKgWnnHRVad_m8');
  // final res = await adminListenerDS.getListeners();
  // res.fold((l) => (print(l.message)), (r) {
  //   for (int i = 0; i < r.listeners.length; i++) {
  //     String x =
  //         "${r.listeners[i]}, ${r.listeners[i].name}, ${r.listeners[i].email}, ${r.listeners[i].id}";
  //     print(x);
  //   }
  // });

  // final res1 = await adminListenerDS
  //     .deleteListener(ListenerID(id: "664f34d99d7e3abd157266d4"));

  // res.fold((l) => print(l.message), (r) => null);
// }
