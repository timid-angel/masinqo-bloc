import 'package:masinqo/domain/entities/artists.dart';

abstract class ASignupEvent {}

class ArtistSignupEvent extends ASignupEvent {
  final Artist artist;
  final String confirmPassword;

  ArtistSignupEvent({
    required this.artist,
    required this.confirmPassword,
  });
}

class AResetState extends ASignupEvent {}
