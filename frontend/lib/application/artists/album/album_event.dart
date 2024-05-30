import 'package:flutter/material.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';

abstract class AlbumEvent {}

class AddSongEvent extends AlbumEvent {
  final String songName;
  final String songFilePath;

  AddSongEvent({
    required this.songName,
    required this.songFilePath,
  });
}

class DeleteAlbumEvent extends AlbumEvent {
  final String albumId;
  final ArtistHomeBloc artistHomeBloc;
  final BuildContext context;

  DeleteAlbumEvent(
      {required this.albumId,
      required this.artistHomeBloc,
      required this.context});
}

class DeleteSongEvent extends AlbumEvent {
  final String songName;
  final String albumId;

  DeleteSongEvent({required this.songName, required this.albumId});
}

class AlbumUpdateEvent extends AlbumEvent {
  final String title;
  final String genre;
  final String description;

  AlbumUpdateEvent(
      {required this.title, required this.genre, required this.description});
}
