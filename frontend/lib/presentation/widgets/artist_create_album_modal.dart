import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateAlbumModal extends StatefulWidget {
  const CreateAlbumModal({super.key});

  @override
  CreateAlbumModalState createState() => CreateAlbumModalState();
}

class CreateAlbumModalState extends State<CreateAlbumModal> {
  late TextEditingController _nameController;
  late TextEditingController _genreController;
  late TextEditingController _descriptionController;
  String? _thumbnailPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _genreController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _thumbnailPath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Album',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF39DCF3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Album name',
                  hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39DCF3)), 
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
              const SizedBox(height: 10),
              TextField(
                controller: _genreController,
                decoration: const InputDecoration(
                  hintText: 'Genre',
                  hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39DCF3)), 
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39DCF3)), 
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _pickImage,
                child: Text(
                  _thumbnailPath != null
                      ? 'Change Thumbnail'
                      : 'Pick Thumbnail',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (_thumbnailPath != null)
                Image.file(
                  File(_thumbnailPath!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39DCF3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
