import 'package:equatable/equatable.dart';

abstract class SongState extends Equatable {
  const SongState();

  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongSuccess extends SongState {
  final String message;

  const SongSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SongFailure extends SongState {
  final String errorMessage;

  const SongFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
