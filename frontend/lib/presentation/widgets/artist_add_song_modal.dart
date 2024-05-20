import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddSongModal extends StatefulWidget {
  const AddSongModal({super.key});

  @override
  AddSongModalState createState() => AddSongModalState();
}

class AddSongModalState extends State<AddSongModal> {
  late final TextEditingController _songNameController = TextEditingController();
  late String _filePath = '';

  void _pickSong() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, 
      allowedExtensions: ['mp3'], 
    );
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const Text(
              'Add Song',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _songNameController,
              decoration: const InputDecoration(
                hintText: 'Enter song name',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39DCF3)), 
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _pickSong,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, 
                foregroundColor: Colors.white, 
              ),
              child: const Text('Pick Song File'),
            ),
            if (_filePath.isNotEmpty)
              Text(
                'Selected file: $_filePath',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                final String songName = _songNameController.text.trim();
                if (songName.isNotEmpty && _filePath.isNotEmpty) {
                  
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a song name and pick a file.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Add Song' ,style: TextStyle(color: Color(0xFF39DCF3) )),
            ),
          ],
        ),
      ),
    );
  }
}
