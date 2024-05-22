class LoginDTO {
  final String email;
  final String password;

  LoginDTO({required this.email, required this.password});

  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'password': String password,
      } =>
        LoginDTO(
          email: email,
          password: password,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
