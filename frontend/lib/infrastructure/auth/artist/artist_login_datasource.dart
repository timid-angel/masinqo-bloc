
import 'package:masinqo/infrastructure/core/url.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:http/http.dart' as http;


class ArtistLoginDataSource {
  final String url = Domain.url;

  Future<http.Response> artistLogin(ArtistLoginDTO loginDto) async {
    http.Response response =
        await http.post(Uri.parse("$url/auth/artist/login"), body: {
      "email": loginDto.email,
      "password": loginDto.password,
    });

    return response;
  }
}
