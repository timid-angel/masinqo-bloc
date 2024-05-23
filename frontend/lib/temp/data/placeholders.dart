import 'package:masinqo/temp/models/albums.dart';
import 'package:masinqo/temp/models/artists.dart';
import 'package:masinqo/temp/models/listener.dart';
import 'package:masinqo/temp/models/playlist.dart';
import 'package:masinqo/temp/models/songs.dart';

Artist pArtist = Artist(
  name: "",
  email: "",
  password: "",
  albums: [],
  profilePicture: "",
);

Album pAlbum = Album(
  albumArt: '',
  artist: pArtist,
  date: DateTime.now(),
  description: '',
  genre: '',
  songs: [],
  title: '',
);

Song pSong = Song(
  album: pAlbum,
  name: '',
  filePath: '',
);

Listener pListener = Listener(
  name: "",
  email: "",
  password: "",
  playlists: [],
  favorites: [],
);

Playlist pPlaylist = Playlist(
  name: "",
  creationDate: DateTime.now(),
  owner: pListener,
  description: "",
  songs: [],
);
