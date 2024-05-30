import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/listener/listener_album_repo.dart';
import 'package:masinqo/infrastructure/listener/listener_album/listener_album_service.dart';

class ListenerAlbumRepository implements AlbumRepository {
  final ListenerAlbumService listenerAlbumService;
  ListenerAlbumRepository(this.listenerAlbumService);

  @override
  Future<List<Album>> getAlbums() async {
    final ress = await listenerAlbumService.getAlbums();
    return ress;
  }
}

// void main() async {
//   ListenerAlbumRepository lar = ListenerAlbumRepository(ListenerAlbumService());
//   final res = await lar.getAlbums();
//   for (int i = 0; i < res.length; i++) {
//     String s = " ${res[i].title}, ${res[i].artist}}";
//     print(s);
//   }

// }
