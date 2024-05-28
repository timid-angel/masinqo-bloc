import 'package:equatable/equatable.dart';

abstract class ArtistSignupState extends Equatable {
  const ArtistSignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends ArtistSignupState {}

class SignupLoading extends ArtistSignupState {}

class ArtistSignupSuccess extends ArtistSignupState {}

class ArtistSignupFailure extends ArtistSignupState {
  final String error;

  const ArtistSignupFailure({required this.error});
}
