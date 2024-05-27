import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';

class ListenerLoginDataSource {
  final String url = Domain.url;
  // final String url = "http://localhost:3000";

  Future<http.Response> listenerLogin(ListenerLoginDTO loginDto) async {
    http.Response response =
        await http.post(Uri.parse("$url/auth/listener/login"), body: {
      "email": loginDto.email,
      "password": loginDto.password,
    });

    return response;
  }
}
