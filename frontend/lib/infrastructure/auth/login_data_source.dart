import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/auth/login_dto.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class LoginDataSource {
  final String url = Domain.url;

  Future<http.Response> adminLogin(LoginDTO loginDto) async {
    http.Response response =
        await http.post(Uri.parse("$url/auth/admin/login"), body: {
      "email": loginDto.email,
      "password": loginDto.password,
    });

    return response;
  }
}
