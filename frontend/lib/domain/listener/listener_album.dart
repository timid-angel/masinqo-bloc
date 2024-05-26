import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_repository.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_service.dart';

class ListenerAlbumCollection {
  late List<Album> albums;
  // final String token;

  ListenerAlbumCollection();
  Future<List<Album>> getAlbums() async {
    // if (token.isEmpty) {
    //   return Exception('Invalid token');
    // }

    final res =
        await ListenerAlbumRepository(ListenerAlbumService()).getAlbums();
    return res;
  }
}
