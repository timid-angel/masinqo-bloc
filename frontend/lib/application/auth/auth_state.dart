class AuthState {
  final String role;
  String token = "";
  List<String> errors = [];

  AuthState({this.token = "", required this.role});
}
