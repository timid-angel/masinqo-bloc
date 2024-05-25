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


