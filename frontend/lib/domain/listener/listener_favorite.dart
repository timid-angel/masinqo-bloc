import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_favorite/listener_fav_service.dart';

class ListenerFavCollection {
  late List<Album> albums;
  final String token;

  ListenerFavCollection({required this.token});
  Future<List<Album>> getFavorites() async {
    if (token.isEmpty) {
      throw Exception('Invalid token');
    }

    final res = await ListenerFavRepository(ListenerFavService(token: token))
        .getFavorites();
    return res;
  }
}
