import 'package:equatable/equatable.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

abstract class UpdateAlbumEvent extends Equatable {
  const UpdateAlbumEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAlbum extends UpdateAlbumEvent {
  final UpdateAlbumDTO updateDto;

  const UpdateAlbum(this.updateDto);

  @override
  List<Object?> get props => [updateDto];
}
