import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/artist_song_card.dart';
import 'package:masinqo/temp/audio_manager/artist_audio_manager.dart';

void main() {
  testWidgets("Artist Song Card Widget", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SongCard(
          artistName: "test_artist_name",
          audioManager: AudioManager(),
          imagePath: "",
          songFilePath: "",
          songName: "test_song_name",
          songNumber: 4,
        ),
      ),
    ));

    final text1Finder = find.text("test_song_name");
    final text2Finder = find.text("4");

    expect(text1Finder, findsOneWidget);
    expect(text2Finder, findsOneWidget);
  });
}
