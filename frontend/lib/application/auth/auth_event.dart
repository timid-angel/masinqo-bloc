abstract class AdminAuthEvent {}

abstract class ArtistAuthEvent {}

abstract class ListenerAuthEvent {}

class AdminLoginEvent extends AdminAuthEvent {
  final String email;
  final String password;
  final String role;

  AdminLoginEvent({
    required this.email,
    required this.password,
    required this.role,
  });
}

class ArtistLoginEvent extends ArtistAuthEvent {
  final String email;
  final String password;

  ArtistLoginEvent({
    required this.email,
    required this.password,
  });
}

class ListenerLoginEvent extends ListenerAuthEvent {
  final String email;
  final String password;

  ListenerLoginEvent({
    required this.email,
    required this.password,
  });
}
