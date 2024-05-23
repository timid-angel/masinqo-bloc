import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_failures.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_success.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class AdminArtistDataSource implements AdminArtistRepository {
  // final String url = Domain.url;
  final String url = "http://localhost:3000";
  final String token;

  AdminArtistDataSource({required this.token});

  @override
  Future<Either<ArtistFetchFailure, ArtistFetchSuccess>> getArtists() async {
    http.Response response =
        await http.get(Uri.parse("$url/artists"), headers: {
      "Cookie": token,
    });

    if (!(response.statusCode == 200)) {
      final Map res = jsonDecode(response.body);
      return Left(ArtistFetchFailure(message: res["message"]));
    }

    List<AdminArtist> res = [];
    List artists = jsonDecode(response.body);
    for (int i = 0; i < artists.length; i++) {
      res.add(
        AdminArtist(
          id: artists[i]["_id"],
          email: artists[i]["email"],
          name: artists[i]["name"],
          isBanned: artists[i]["banned"],
          profilePicture: artists[i]["profilePicture"],
        ),
      );
    }

    return Right(ArtistFetchSuccess(artists: res));
  }

  @override
  Future<Either<ArtistDeleteFailure, ArtistDeleteSuccess>> deleteArtist(
      ArtistID artist) async {
    http.Response response =
        await http.delete(Uri.parse("$url/artists/${artist.id}"), headers: {
      "Cookie": token,
    });

    if (!(response.statusCode == 200)) {
      final Map res = jsonDecode(response.body);
      return Left(ArtistDeleteFailure(message: res["message"]));
    }

    return Right(ArtistDeleteSuccess());
  }

  @override
  Future<Either<ArtistStatusChangeFailure, ArtistStatusChangeSuccess>>
      changeStatus(ArtistStatus artist) async {
    String op = artist.status ? "unban" : "ban";
    http.Response response = await http.delete(
      Uri.parse("$url/artists/$op/${artist.id}"),
      headers: {
        "Cookie": token,
      },
    );

    if ((response.statusCode < 300)) {
      final Map res = jsonDecode(response.body);
      return Left(ArtistStatusChangeFailure(message: res["message"]));
    }

    return Right(ArtistStatusChangeSuccess());
  }
}

void main() async {
  AdminArtistDataSource adminListenerDS = AdminArtistDataSource(
      token:
          'accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NDkzMzQ4YjUyOTkyM2I5YmI5ZGFkNSIsInJvbGUiOjAsImlhdCI6MTcxNjQ2MzgxOCwiZXhwIjoxNzE2NTUwMjE4fQ.Strn3-PIJ9DeA74r0mb4BTtilYI07tKgWnnHRVad_m8');

  // final res = await adminListenerDS.getArtists();
  // res.fold((l) => (print(l.message)), (r) {
  //   for (int i = 0; i < r.artists.length; i++) {
  //     String x =
  //         "${r.artists[i]}, ${r.artists[i].name}, ${r.artists[i].email}, ${r.artists[i].id}, ${r.artists[i].isBanned}, ${r.artists[i].profilePicture}";
  //     print(x);
  //   }
  // });

  // final res1 = await adminListenerDS
  //     .deleteArtist(ArtistID(id: "66495225005b908be0a020a3"));

  // res1.fold((l) => print(l.message), (r) => null);

  final res2 = await adminListenerDS
      .changeStatus(ArtistStatus(id: "664f34d99d7e3abd157266d4", status: true));

  res2.fold((l) => print(l.message), (r) => null);
}
