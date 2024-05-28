import 'package:masinqo/domain/entities/listener.dart';

class ListenerSignupDTO {
  final String name;
  final String email;
  final String password;

  ListenerSignupDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  Listener toListener() {
    return Listener(
      name: name,
      email: email,
      password: password, playlists: [], favorites: [],
    );
  }
}