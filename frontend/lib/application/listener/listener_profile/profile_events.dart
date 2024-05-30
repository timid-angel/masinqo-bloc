abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {
  final String token;
  FetchProfile({required this.token});
}

class EditProfile extends ProfileEvent {
  final String token;
  final String name;
  final String email;
  final String password;

  EditProfile(
      {required this.token,
      required this.name,
      required this.email,
      required this.password});
}
