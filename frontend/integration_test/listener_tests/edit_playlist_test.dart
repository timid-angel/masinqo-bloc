import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/screens/listener_playlist.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_albums_test.dart'; // Ensure you import flutter_bloc package

class MockPlaylistBloc extends MockBloc <PlaylistEvent, PlaylistState> implements PlaylistBloc {}

class PlaylistEventFake extends Fake implements PlaylistEvent {}
class PlaylistStateFake extends Fake implements PlaylistState {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(PlaylistEventFake());
    registerFallbackValue(PlaylistStateFake());
  });

  group('Edit Playlist Integration Test', () {
    late PlaylistBloc playlistBloc;

    setUp(() {
      playlistBloc = MockPlaylistBloc();
    });

    testWidgets('User can edit a playlist', (WidgetTester tester) async {
      final playlist = Playlist(
        id: '1',
        name: 'My Playlist',
        creationDate: DateTime.now(),
        owner: 'user',
        description: '',
        songs: [],
      );

      when(() => playlistBloc.state).thenReturn(LoadedPlaylist([playlist]));

      when(() => playlistBloc.update(any())).thenAnswer((invocation) {
        final event = invocation.positionalArguments.first as PlaylistEvent;
        if (event is EditPlaylists) {
          playlistBloc.emit(LoadedPlaylist([
            Playlist(
              id: '1',
              name: 'New Playlist Name',
              creationDate: DateTime.now(),
              owner: 'user',
              description: '',
              songs: [],
            ),
          ]));
        }
      });

      // await tester.pumpWidget(
      //   MaterialApp(
      //     home: BlocProvider(
      //       create: (_) => playlistBloc,
      //       child: Scaffold(
      //         body: PlaylistWidget(
      //           token: 'token',
      //           playlist: playlist,
      //         ),
      //       ),
      //     ),
      //   ),
      // );

      expect(find.text('My Playlist'), findsOneWidget);

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'New Playlist Name');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('New Playlist Name'), findsOneWidget);
      expect(find.text('My Playlist'), findsNothing);
    });
  });
}