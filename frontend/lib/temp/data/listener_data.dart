import 'package:masinqo/temp/data/album_data.dart';
import 'package:masinqo/temp/models/albums.dart';
import 'package:masinqo/temp/models/listener.dart';
import 'package:masinqo/temp/models/playlist.dart';

List<Listener> listenerData = [
  Listener(
    name: "Lidiya",
    email: "notlidiya@gmail.com",
    password: "lidiya123",
    playlists: <Playlist>[],
    favorites: <Album>[
      albumData[5],
      albumData[2],
    ],
  ),
  Listener(
    name: "Mati",
    email: "notmati@gmail.com",
    password: "mati123",
    playlists: <Playlist>[],
    favorites: <Album>[
      albumData[0],
      albumData[1],
    ],
  ),
  Listener(
    name: "Nathan",
    email: "notnathan@gmail.com",
    password: "nathan123",
    playlists: <Playlist>[],
    favorites: <Album>[
      ...albumData,
      ...albumData,
      ...albumData,
    ],
  ),
  Listener(
    name: "Natanim",
    email: "notnatanim@gmail.com",
    password: "natanim123",
    playlists: <Playlist>[],
    favorites: <Album>[
      albumData[3],
      albumData[4],
    ],
  ),
];
