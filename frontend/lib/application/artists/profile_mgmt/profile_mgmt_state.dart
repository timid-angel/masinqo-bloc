import 'package:equatable/equatable.dart';

abstract class UpdateArtistState extends Equatable {
  const UpdateArtistState();

  @override
  List<Object?> get props => [];
}

class UpdateArtistInitial extends UpdateArtistState {}

class UpdateArtistLoading extends UpdateArtistState {}

class UpdateArtistFailure extends UpdateArtistState {
  final String message;

  const UpdateArtistFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateArtistSuccess extends UpdateArtistState {}
