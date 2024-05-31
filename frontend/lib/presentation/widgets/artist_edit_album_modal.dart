import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class EditSongModal extends StatelessWidget {
  late final TextEditingController titleController;
  late final TextEditingController genreController;
  late final TextEditingController descriptionController;
  final AlbumBloc albumBloc;
  final ArtistHomeBloc artistHomeBloc;

  EditSongModal({
    super.key,
    required this.albumBloc,
    required this.artistHomeBloc,
  }) {
    titleController = TextEditingController(text: albumBloc.state.title);
    genreController = TextEditingController(text: albumBloc.state.genre);
    descriptionController =
        TextEditingController(text: albumBloc.state.description);
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
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Edit Album',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Album Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                key:Key('title_field'),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter new album name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Genre",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                key: Key('genre_field'),
                controller: genreController,
                decoration: const InputDecoration(
                  hintText: 'Enter new genre',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                key: Key('description_field'),
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter new description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  albumBloc.add(
                    AlbumUpdateEvent(
                      description: descriptionController.text,
                      genre: genreController.text,
                      title: titleController.text,
                    ),
                  );
                  artistHomeBloc.add(HomeAlbumUpdateEvent(
                    description: descriptionController.text,
                    genre: genreController.text,
                    title: titleController.text,
                    albumId: albumBloc.state.albumId,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Edited Album Successfully"),
                      backgroundColor: Color.fromARGB(255, 34, 126, 25),
                    ),
                  );
                  context.pop();
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Color(0xFF39DCF3)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
