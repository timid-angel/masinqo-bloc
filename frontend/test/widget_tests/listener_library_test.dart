import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';

void main() {
  testWidgets('Listener Library Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PlaylistBloc>(
          create: (context) =>
              PlaylistBloc(playlistRepository: ListenerPlaylistCollection()),
          child: const ListenerLibrary(token: ""),
        ),
      ),
    );

    expect(find.text('Playlists'), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });
}
