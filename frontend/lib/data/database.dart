import 'package:masinqo/models/admin.dart';
import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/artists.dart';
import 'package:masinqo/models/listener.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/songs.dart';

class Database {
  final List<Admin> admins;
  final List<Album> albums;
  final List<Artist> artists;
  final List<Listener> listeners;
  final List<Playlist> playlists;
  final List<Song> songs;

  Database({
    required this.admins,
    required this.albums,
    required this.artists,
    required this.listeners,
    required this.playlists,
    required this.songs,
  }) {
    initialize();
  }

  void initialize() {
    // albums and songs
    albums[0].songs = [songs[0], songs[1]];
    albums[1].songs = [...songs];
    albums[2].songs = [...songs];
    albums[3].songs = [...songs, ...songs];
    albums[4].songs = [songs[2], songs[3], songs[4], songs[5], songs[6]];
    albums[5].songs = [...songs];

    // artists and albums
    artists[0].albums = [albums[0], albums[1]];
    artists[1].albums = [albums[2], albums[3]];
    artists[2].albums = [albums[4]];
    artists[3].albums = [...albums];

    // albums and artists
    albums[0].artist = artists[0];
    albums[1].artist = artists[1];
    albums[2].artist = artists[1];
    albums[3].artist = artists[2];
    albums[4].artist = artists[2];
    albums[5].artist = artists[3];

    // playlists and songs
    playlists[0].songs = [songs[0], songs[1], songs[2]];
    playlists[1].songs = [songs[3], songs[4], songs[5]];
    playlists[2].songs = [...songs, ...songs, ...songs];
    playlists[3].songs = [songs[6], songs[3], songs[1]];

    // songs and albums
    songs[0].album = albums[0];
    songs[1].album = albums[0];
    songs[2].album = albums[5];
    songs[3].album = albums[5];
    songs[4].album = albums[5];
    songs[5].album = albums[5];
    songs[6].album = albums[5];
    songs[7].album = albums[5];
  }
}
