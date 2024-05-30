import 'package:masinqo/domain/entities/profile.dart';

abstract class ProfileState {}

class EmptyProfile extends ProfileState {}

class LoadedProfile extends ProfileState {
  final Profile profile;
  LoadedProfile(this.profile);
}

class ErrorProfile extends ProfileState {
  final String error;

  ErrorProfile(this.error);
}
