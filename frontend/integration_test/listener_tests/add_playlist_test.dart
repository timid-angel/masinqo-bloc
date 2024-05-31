import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/screens/listener_add_playlist.dart';
import 'package:mocktail/mocktail.dart';
import 'get_albums_test.dart';

class MockPlaylistBloc extends MockBloc <PlaylistEvent, PlaylistState>
    implements PlaylistBloc {}

class PlaylistEventFake extends Fake implements PlaylistEvent {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(PlaylistEventFake());
  });

  group('Create Playlist Integration Test', () {
    late PlaylistBloc playlistBloc;

    setUp(() {
      playlistBloc = MockPlaylistBloc();
    });

    testWidgets('User can create a playlist', (WidgetTester tester) async {
      when(() => playlistBloc.state).thenReturn(EmptyPlaylist());
      when(() => playlistBloc.add(any())).thenAnswer((invocation) {
        final event = invocation.positionalArguments.first as PlaylistEvent;
        if (event is CreatePlaylists) {
          playlistBloc.emit(LoadedPlaylist([
            Playlist(
              id: '1',
              name: event.name,
              creationDate: DateTime.now(),
              owner: 'user',
              description: '',
              songs: [],
            ),
          ]));
        }
      });
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddPlaylistWidget(token: 'token'),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'My Playlist');
      await tester.tap(find.text('Create Playlist'));
      await tester.pumpAndSettle();


      expect(find.text('My Playlist'), findsOneWidget);
    });
  });
}