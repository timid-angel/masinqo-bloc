import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/user.dart';

class Artist extends User {
  List<Album> albums;
  String profilePicture;

  Artist({
    required super.name,
    required super.email,
    required super.password,
    required this.albums,
    required this.profilePicture,
  });
}
