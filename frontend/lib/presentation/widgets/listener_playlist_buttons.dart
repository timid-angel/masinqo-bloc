import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/listener_delete_playlist_modal.dart';
import 'listener_edit_playlist_modal.dart';

class PlaylistButtonsWidget extends StatelessWidget {
  final Function() editController;
  final dynamic Function() deleteController;
  final String playlistName;
  final String token;
  final String id;
  final PlaylistBloc bloc;

  const PlaylistButtonsWidget({
    super.key,
    required this.bloc,
    required this.id,
    required this.editController,
    required this.deleteController,
    required this.playlistName,
    required this.token,
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
                return BlocProvider.value(
                  value: bloc,
                  child: EditPlaylistModal(
                    token: token,
                    id: id,
                    currentPlaylistName: playlistName,
                  ),
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
                return BlocProvider.value(
                  value: bloc,
                  child: DeletePlaylistModal(id: id, token: token),
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
