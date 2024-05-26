class AuthState {
  final String role;
  String token = "";
  List<String> errors = [];
  bool isLoading = false;

  AuthState({this.token = "", required this.role, this.isLoading = false});
}
