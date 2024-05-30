import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_bloc.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';
import 'package:masinqo/presentation/screens/listener_playlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_buttons.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_headline.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_songlist.dart';

void main() {
  testWidgets('Listener Playlist Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlaylistWidget(
          playlist: Playlist(
            name: 'test_pl',
            creationDate: DateTime.now(),
            description: "test_desc",
            owner: "test_owner",
            songs: [],
            id: '',
          ),
          token: '',
          bloc: PlaylistBloc(playlistRepository: ListenerPlaylistCollection()),
        ),
      ),
    );

    expect(find.byType(NestedScrollView), findsOneWidget);
    expect(find.byType(ListenerAppbar), findsOneWidget);
    expect(find.byType(Stack), findsExactly(2));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(PlaylistAlbumArt), findsOneWidget);
    expect(find.byType(PlaylistHeadlineWidget), findsOneWidget);
    expect(find.byType(PlaylistButtonsWidget), findsOneWidget);
    expect(find.byType(PlaylistTracksWidget), findsOneWidget);
    expect(find.text("test_pl"), findsOneWidget);
  });
}
