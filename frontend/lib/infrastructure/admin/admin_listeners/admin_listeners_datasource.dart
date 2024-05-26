import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';

class AdminListenersDatasource {
  final String url = Domain.url;
  final String token;

  AdminListenersDatasource({required this.token});

  Future<http.Response> getListeners() async {
    http.Response response =
        await http.get(Uri.parse("$url/listener"), headers: {
      "Cookie": token,
    });

    return response;
  }

  Future<http.Response> deleteListener(String listenerId) async {
    http.Response response =
        await http.delete(Uri.parse("$url/listener/$listenerId"), headers: {
      "Cookie": token,
    });

    return response;
  }
}
