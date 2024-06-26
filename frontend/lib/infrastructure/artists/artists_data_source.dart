import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/core/url.dart';

class ArtistsDataSource {
  final String url = Domain.url;
  String token;
  ArtistsDataSource({required this.token}) {
    if (token.startsWith("accessToken=")) {
      token = token.split("=")[1];
    }
  }

  Future<http.Response> getArtistInformation() async {
    http.Response response =
        await http.get(Uri.parse("$url/artists/info"), headers: {
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

  Future<http.StreamedResponse> updateArtistInfo(
      Map<String, String> body, String filePath) async {
    var headers = {'Cookie': 'accessToken=$token'};
    var request =
        http.MultipartRequest('PATCH', Uri.parse('$url/artists/update'));

    request.fields.addAll(body);
    request.headers.addAll(headers);

    if (filePath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('profilePicture', filePath));
    }

    return await request.send();
  }

  Future<http.Response> getAlbums() async {
    http.Response response = await http.get(Uri.parse("$url/albums"), headers: {
      "Cookie": "accessToken=$token",
    });

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

  Future<http.Response> getSongs(String albumId) async {
    http.Response response = await http.get(Uri.parse("$url/albums/$albumId"),
        headers: {"Cookie": "accessToken=$token"});

    return response;
  }

  Future<http.Response> deleteSong(String albumId, String songName) async {
    http.Response response = await http.delete(
      Uri.parse("$url/albums/songs/$albumId"),
      headers: {"Cookie": "accessToken=$token"},
      body: {"name": songName},
    );

    return response;
  }

  Future<http.StreamedResponse> addSong(
      String albumId, String songName, String songFilePath) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$url/albums/songs/$albumId"));
    request.fields["name"] = songName;

    final httpImage = await http.MultipartFile.fromPath("song", songFilePath);

    request.files.add(httpImage);
    request.headers["Cookie"] = "accessToken=$token";
    request.headers["Content-Type"] = 'multipart/form-data';
    http.StreamedResponse response = await request.send();

    return response;
  }
}
