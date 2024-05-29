import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/entities/songs.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/widgets/artist_add_song_modal.dart';
import 'package:masinqo/presentation/widgets/artist_app_bar.dart';
import 'package:masinqo/presentation/widgets/artist_edit_album_modal.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';

void main() {
  group("Artist Album Page", () {
    testWidgets('Page and Add Button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArtistsAlbumPage(
            album: Album(
              title: "test_title",
              songs: [
                Song(name: "song1", filePath: ""),
                Song(name: "song2", filePath: ""),
              ],
              albumArt: "",
              genre: "test_genre",
              description: "test_desc",
              date: DateTime.now(),
              artist: "",
            ),
          ),
        ),
      );

      expect(find.byType(ArtistAppBar), findsOneWidget);
      expect(find.text("2 Tracks"), findsOneWidget);
      expect(find.text('Add Song'), findsOneWidget);
      expect(find.text('Edit Album'), findsOneWidget);
      expect(find.text('Delete Album'), findsOneWidget);
      expect(find.text('Tracks'), findsOneWidget);

      final addSongButton = find.text('Add Song');
      await tester.tap(addSongButton);
      await tester.pump();
      expect(find.byType(AddSongModal), findsOneWidget);
    });

    testWidgets('Edit Button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArtistsAlbumPage(
            album: Album(
              title: "test_title",
              songs: [
                Song(name: "song1", filePath: ""),
                Song(name: "song2", filePath: ""),
              ],
              albumArt: "",
              genre: "test_genre",
              description: "test_desc",
              date: DateTime.now(),
              artist: "",
            ),
          ),
        ),
      );
      final editAlbumButton = find.text('Edit Album');
      await tester.tap(editAlbumButton);
      await tester.pump();
      expect(find.byType(EditSongModal), findsOneWidget);
    });

    testWidgets('Delete Button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArtistsAlbumPage(
            album: Album(
              title: "test_title",
              songs: [
                Song(name: "song1", filePath: ""),
                Song(name: "song2", filePath: ""),
              ],
              albumArt: "",
              genre: "test_genre",
              description: "test_desc",
              date: DateTime.now(),
              artist: "",
            ),
          ),
        ),
      );

      final deleteAlbumButton = find.text('Delete Album');
      await tester.tap(deleteAlbumButton);
      await tester.pump();
      expect(find.byType(DeleteConfirmationDialog), findsOneWidget);
    });
  });
}
