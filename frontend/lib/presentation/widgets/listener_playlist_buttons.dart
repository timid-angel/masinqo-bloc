import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';
import 'delete_confirmation_modal.dart';
import 'listener_edit_playlist_modal.dart';

class PlaylistButtonsWidget extends StatelessWidget {
  final Function() editController;
  final dynamic Function() deleteController;
  final String playlistName;

  const PlaylistButtonsWidget({
    super.key,
    required this.editController,
    required this.deleteController,
    required this.playlistName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditPlaylistModal(
                  currentPlaylistName: playlistName,
                );
              },
            ).then((newPlaylistName) {
              if (newPlaylistName != null) {}
            });
          },
          child: const Row(
            children: [
              Icon(
                Icons.edit,
                color: AppColors.listener2,
              ),
              SizedBox(width: 2),
              Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DeleteConfirmationDialog(
                  title: 'Are you sure you want to delete this playlist?',
                  content: '',
                  onConfirm: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          child: const Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 2),
              Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
