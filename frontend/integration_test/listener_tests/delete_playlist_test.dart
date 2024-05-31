import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';

// Mock repository should implement or extend the correct type
class MockPlaylistRepository extends Mock implements ListenerPlaylistCollection {}

class MockPlaylistBloc extends MockBloc<PlaylistEvent, PlaylistState>
    implements PlaylistBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Delete Playlist Integration Test', (WidgetTester tester) async {
    final mockRepository = MockPlaylistRepository();

    final playlists = [
      Playlist(id: '1', name: 'Playlist 1', songs: [], creationDate: DateTime.now(), owner: '', description: ''),
      Playlist(id: '2', name: 'Playlist 2', songs: [], creationDate: DateTime.now(), owner: '', description: ''),
    ];

 
    when(() => mockRepository.getPlaylists(any())).thenAnswer((_) async => playlists);
    when(() => mockRepository.deletePlaylist(any(), any())).thenAnswer((_) async {
      playlists.removeWhere((playlist) => playlist.id == '1');
    });


    final playlistBloc = PlaylistBloc(playlistRepository: mockRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PlaylistBloc>.value(
          value: playlistBloc,
          child: ListenerHome(token: 'dummy_token'),
        ),
      ),
    );

    await tester.pumpAndSettle();


    expect(find.text('Playlist 1'), findsOneWidget);
    expect(find.text('Playlist 2'), findsOneWidget);


    playlistBloc.add(DeletePlaylists(id: '1', token: 'dummy_token'));

    await tester.pumpAndSettle();


    expect(find.text('Playlist 1'), findsNothing);
    expect(find.text('Playlist 2'), findsOneWidget);
  });
}