import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';

class EditPlaylistModal extends StatefulWidget {
  final String currentPlaylistName;
  final String token;
  final String id;

  const EditPlaylistModal({
    required this.id,
    super.key,
    required this.token,
    required this.currentPlaylistName,
  });

  @override
  EditPlaylistModalState createState() => EditPlaylistModalState();
}

class EditPlaylistModalState extends State<EditPlaylistModal> {
  late String _newPlaylistName;

  @override
  void initState() {
    super.initState();
    _newPlaylistName = widget.currentPlaylistName;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Edit Playlist', style: TextStyle(color: Colors.white)),
      content: TextFormField(
        initialValue: widget.currentPlaylistName,
        onChanged: (value) {
          setState(() {
            _newPlaylistName = value;
          });
        },
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Enter new playlist name',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            // print("id: ${widget.id}");
            BlocProvider.of<PlaylistBloc>(context).add(EditPlaylists(
                token: widget.token, id: widget.id, name: _newPlaylistName));
            BlocProvider.of<PlaylistBloc>(context).add(FetchPlaylists(
              token: widget.token,
            ));
            Navigator.pop(context, _newPlaylistName);
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}
