import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';

class AdminArtistsDatasource {
  final String url = Domain.url;
  final String token;

  AdminArtistsDatasource({required this.token});

  Future<http.Response> getArtists() async {
    http.Response response =
        await http.get(Uri.parse("$url/artists"), headers: {
      "Cookie": token,
    });

    return response;
  }

  Future<http.Response> deleteArtist(String artistId) async {
    http.Response response =
        await http.delete(Uri.parse("$url/artists/$artistId"), headers: {
      "Cookie": token,
    });

    return response;
  }

  Future<http.Response> changeStatus(String operation, String artistId) async {
    http.Response response = await http.patch(
      Uri.parse("$url/artists/$operation/$artistId"),
      headers: {
        "Cookie": token,
      },
    );

    return response;
  }
}
