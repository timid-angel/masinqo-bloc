import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/listener/listener_favorite_repo.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_service.dart';

class ListenerFavRepository implements FavoriteRepository {
  final ListenerFavService listenerFavService;
  ListenerFavRepository(this.listenerFavService);

  @override
  Future<List<Album>> getFavorites(String token) async {
    return await listenerFavService.getFavorites(token);
  }

  @override
  Future<void> addFavorite(String id, String token) async {
    await listenerFavService.addFavorite(id, token);
  }

  @override
  Future<void> deleteFavorite(String id, String token) async {
    await listenerFavService.deleteFavorite(id, token);
  }
}

// void main() async {
//   ListenerFavRepository lfr = ListenerFavRepository(ListenerFavService(
//       token:
//           "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTMwN2ZhNTA1YTI2MDBmOTI0ZjJhMyIsInJvbGUiOjIsImlhdCI6MTcxNjczMzczOSwiZXhwIjoxNzE2ODIwMTM5fQ.Ma_YF_Gt8NuBpa3N_WDKEwhi55V6QMIFNWsP72EptXs"));

//   final res = await lfr.getFavorites();
//   print(res);
//   for (int i = 0; i < res.length; i++) {
//     String s = "${res[i].description}, ${res[i].title}, ${res[i].artist}}";
//     // var s = res[i];

//     print(s);
//   }
// }
