import 'package:masinqo/infrastructure/core/url.dart';
// listener_login_datasource.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
class ArtistLoginDTO {
  final String email;
  final String password;

  ArtistLoginDTO({required this.email, required this.password});
}

