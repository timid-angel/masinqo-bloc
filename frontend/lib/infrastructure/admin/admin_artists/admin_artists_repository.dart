import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:masinqo/domain/admin/admin_artists/admin_artists_repository_interface.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_datasource.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_failures.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_success.dart';

class AdminArtistsRepository implements AdminArtistRepositoryInterface {
  final String token;

  AdminArtistsRepository({required this.token});
  @override
  Future<Either<ArtistFetchFailure, ArtistFetchSuccess>> getArtists() async {
    http.Response response =
        await AdminArtistsDatasource(token: token).getArtists();

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
        await AdminArtistsDatasource(token: token).deleteArtist(artist.id);

    if (!(response.statusCode == 200)) {
      final Map res = jsonDecode(response.body);
      return Left(ArtistDeleteFailure(message: res["message"]));
    }

    return Right(ArtistDeleteSuccess());
  }

  @override
  Future<Either<ArtistStatusChangeFailure, ArtistStatusChangeSuccess>>
      changeStatus(ArtistStatus artist) async {
    String op = artist.newBannedStatus ? "unban" : "ban";
    http.Response response =
        await AdminArtistsDatasource(token: token).changeStatus(op, artist.id);

    if (response.statusCode > 299) {
      final Map res = jsonDecode(response.body);
      return Left(ArtistStatusChangeFailure(message: res["message"]));
    }

    return Right(ArtistStatusChangeSuccess());
  }
}

// void main() async {
//   AdminArtistsRepository adminListenerDS = AdminArtistsRepository(
//       token:
//           'accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NDkzMzQ4YjUyOTkyM2I5YmI5ZGFkNSIsInJvbGUiOjAsImlhdCI6MTcxNjQ2MzgxOCwiZXhwIjoxNzE2NTUwMjE4fQ.Strn3-PIJ9DeA74r0mb4BTtilYI07tKgWnnHRVad_m8');

//   final res = await adminListenerDS.getArtists();
//   res.fold((l) => (print(l.message)), (r) {
//     for (int i = 0; i < r.artists.length; i++) {
//       String x =
//           "${r.artists[i]}, ${r.artists[i].name}, ${r.artists[i].email}, ${r.artists[i].id}, ${r.artists[i].isBanned}, ${r.artists[i].profilePicture}";
//       print(x);
//     }
//   });

//   final res1 = await adminListenerDS
//       .deleteArtist(ArtistID(id: "66495225005b908be0a020a3"));

//   res1.fold((l) => print(l.message), (r) => null);

//   final res2 = await adminListenerDS
//       .changeStatus(ArtistStatus(id: "664f4334b013d2b68e83a02a", status: true));

//   res2.fold((l) => print(l.message), (r) => null);
// }
