import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';

class ArtistsDataSource {
  // final String url = Domain.url;
  final String url = "http://localhost:3000";
  final String token;

  ArtistsDataSource({required this.token});
  Future<http.Response> getAlbums() async {
    http.Response response = await http.get(Uri.parse("$url/albums"), headers: {
      "Cookie": "accessToken=$token",
    });

    return response;
  }

  Future<http.StreamedResponse> addAlbum(
      Map<String, String> body, String albumArt) async {
    var request = http.MultipartRequest('POST', Uri.parse("$url/albums"));
    request.fields.addAll(body);

    final httpImage = await http.MultipartFile.fromPath("albumArt", albumArt);

    request.files.add(httpImage);
    request.headers["Cookie"] = "accessToken=$token";
    request.headers["Content-Type"] = 'multipart/form-data';
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> updateAlbum(
      String albumId, Map<String, String> body) async {
    http.Response response = await http.put(
      Uri.parse("$url/albums/$albumId"),
      headers: {"Cookie": "accessToken=$token"},
      body: body,
    );

    return response;
  }

  Future<http.Response> deleteAlbum(String albumId) async {
    http.Response response = await http.delete(
        Uri.parse("$url/albums/$albumId"),
        headers: {"Cookie": "accessToken=$token"});

    return response;
  }
}
