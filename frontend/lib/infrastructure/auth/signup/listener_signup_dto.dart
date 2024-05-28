import 'package:masinqo/domain/entities/listener.dart';

class ListenerSignupDTO {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  ListenerSignupDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Listener toListener() {
    return Listener(
      name: name,
      email: email,
      password: password,
      playlists: [],
      favorites: [],
    );
  }
}
