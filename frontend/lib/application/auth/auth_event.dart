abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;

  LoginEvent({
    required this.email,
    required this.password,
    required this.role,
  });
}


class ArtistLoginEvent extends AuthEvent {
  final String email;
  final String password;

  ArtistLoginEvent({
    required this.email,
    required this.password,
  });
}

class ListenerLoginEvent extends AuthEvent {
  final String email;
  final String password;

  ListenerLoginEvent({
    required this.email,
    required this.password,
  });
}
