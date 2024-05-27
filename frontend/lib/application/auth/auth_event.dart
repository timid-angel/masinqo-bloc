abstract class AdminAuthEvent {}

abstract class ArtistAuthEvent {}

abstract class ListenerAuthEvent {}

abstract class LoginPageEvent {}

class AdminLoginEvent extends AdminAuthEvent {
  final String email;
  final String password;

  AdminLoginEvent({
    required this.email,
    required this.password,
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

class SwitchRole extends LoginPageEvent {
  final bool toValue;

  SwitchRole({required this.toValue});
}

class ChangeLoadingStateListener extends ListenerAuthEvent {
  final bool newLoadingState;

  ChangeLoadingStateListener({required this.newLoadingState});
}

class ChangeLoadingStateArtist extends ArtistAuthEvent {
  final bool newLoadingState;

  ChangeLoadingStateArtist({required this.newLoadingState});
}

class ResetErrorsArtists extends ArtistAuthEvent {}

class ResetErrorsListeners extends ListenerAuthEvent {}
