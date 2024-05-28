import 'package:equatable/equatable.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object?> get props => [];
}

class AddSongEvent extends SongEvent {
  final CreateSongDTO songDto;
  final String songFilePath;

  const AddSongEvent({
    required this.songDto,
    required this.songFilePath,
  });

  @override
  List<Object?> get props => [songDto, songFilePath];
}
