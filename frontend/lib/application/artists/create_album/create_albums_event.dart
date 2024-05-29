// abstract class AlbumsEvent {}

// class GetAlbumsArtist extends AlbumsEvent {}

// class RemoveSong extends AlbumsEvent {
//   final String songName;
//   final String albumId;

//   RemoveSong({required this.songName, required this.albumId});
// }

import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

class AddAlbumEvent extends AlbumEvent {
  final String title;
  final String genre;
  final String description;
  final String type;
  final String? albumArt;

  const AddAlbumEvent({
    required this.title,
    required this.genre,
    required this.description,
    required this.type,
    this.albumArt,
  });

  @override
  List<Object?> get props => [title, genre, description, type, albumArt];
}
