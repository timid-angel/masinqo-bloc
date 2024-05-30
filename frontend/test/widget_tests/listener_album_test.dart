import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/presentation/screens/listener_album.dart';
import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
import 'package:masinqo/presentation/widgets/listener_album_songlist.dart';

void main() {
  testWidgets('Listener Album Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AlbumWidget(
          album: Album(
              title: "test_title",
              albumArt: "",
              songs: [],
              description: "test_desc",
              genre: "test_genre",
              date: DateTime.now(),
              artist: "test_owner",
              id: ''),
        ),
      ),
    );

    expect(find.byType(NestedScrollView), findsOneWidget);
    expect(find.byType(Stack), findsNWidgets(2));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(AlbumArt), findsOneWidget);
    expect(find.byType(AlbumHeadlineWidget), findsOneWidget);
    expect(find.byType(AlbumTracksWidget), findsOneWidget);
    expect(find.text("test_title"), findsOneWidget);
  });
}
