import 'package:masinqo/models/albums.dart';
import 'package:masinqo/models/artists.dart';
import 'package:masinqo/models/listener.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/songs.dart';

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
