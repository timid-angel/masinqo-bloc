import 'package:equatable/equatable.dart';
import 'package:masinqo/core.dart';

abstract class UpdateAlbumState extends Equatable {
  const UpdateAlbumState();

  @override
  List<Object?> get props => [];
}

class UpdateAlbumInitial extends UpdateAlbumState {}

class UpdateAlbumLoading extends UpdateAlbumState {}

class UpdateAlbumSuccess extends UpdateAlbumState {
  final Success success;

  const UpdateAlbumSuccess(this.success);

  @override
  List<Object?> get props => [success];
}

class UpdateAlbumFailure extends UpdateAlbumState {
  final String message;

  const UpdateAlbumFailure(this.message);

  @override
  List<Object?> get props => [message];
}
