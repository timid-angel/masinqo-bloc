import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';

class DeletePlaylistModal extends StatelessWidget {
  final String token;
  final String id;

  const DeletePlaylistModal({
    required this.id,
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return DeleteConfirmationDialog(
      title: 'Are you sure you want to delete this playlist?',
      onConfirm: () {
        BlocProvider.of<PlaylistBloc>(context).add(
          DeletePlaylists(token: token, id: id),
        );
        Navigator.of(context).pop();
      },
    );
  }
}
