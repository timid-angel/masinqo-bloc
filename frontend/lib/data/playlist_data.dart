import 'package:masinqo/data/listener_data.dart';
import 'package:masinqo/models/playlist.dart';
import 'package:masinqo/models/songs.dart';

List<Playlist> playlistData = [
  Playlist(
    name: "Car radio",
    creationDate: DateTime.now(),
    description: "This is a description for 'Car radio'",
    owner: listenerData[0],
    songs: <Song>[],
  ),
  Playlist(
    name: "My favorite rap songs",
    creationDate: DateTime.now(),
    description: "This is a description for 'My favorite rap songs'",
    owner: listenerData[1],
    songs: <Song>[],
  ),
  Playlist(
    name: "tub head audio",
    creationDate: DateTime.now(),
    description: "This is a description for 'tub head radio'",
    owner: listenerData[2],
    songs: <Song>[],
  ),
  Playlist(
    name:
        "This is a very long play list name. This overflow for this title must be handled properly",
    creationDate: DateTime.now(),
    description:
        "This is a description for 'This is a very long play list name. This overflow for this title must be handled properly'. This description is also very long and must be handled properly in the UI. This description is also very long and must be handled properly in the UI. This description is also very long and must be handled properly in the UI. This description is also very long and must be handled properly in the UI.",
    owner: listenerData[3],
    songs: <Song>[],
  ),
];
