import 'package:equatable/equatable.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumSuccess extends AlbumState {
  final String message;

  const AlbumSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AlbumFailure extends AlbumState {
  final String errorMessage;

  const AlbumFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
