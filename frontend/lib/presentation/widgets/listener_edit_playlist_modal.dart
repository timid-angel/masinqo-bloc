import 'package:flutter/material.dart';

class EditPlaylistModal extends StatefulWidget {
  final String currentPlaylistName;

  const EditPlaylistModal({
    super.key,
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
            Navigator.pop(context, _newPlaylistName);
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}
