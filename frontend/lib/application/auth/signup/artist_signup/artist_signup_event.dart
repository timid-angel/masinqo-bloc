import 'package:equatable/equatable.dart';
import 'package:masinqo/domain/entities/artists.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class ArtistSignupEvent extends SignupEvent {
  final Artist artist;
  final String confirmPassword;

  const ArtistSignupEvent({
    required this.artist,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [artist, confirmPassword];
}
