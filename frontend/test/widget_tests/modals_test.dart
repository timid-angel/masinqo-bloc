import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/artist_add_song_modal.dart';
import 'package:masinqo/presentation/widgets/artist_create_album_modal.dart';
import 'package:masinqo/presentation/widgets/artist_edit_album_modal.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';
import 'package:masinqo/presentation/widgets/modal_heading.dart';

void main() {
  group("Modals Test", () {
    testWidgets("Add Song Modal Test", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddSongModal()));

      final titleFinder = find.text("Add Song");
      final hintTextFinder = find.text("Enter song name");
      final promptTextFinder = find.text("Pick Song File");
      final textfieldFinder = find.byType(TextField);
      final elevatedBtnFinder = find.byType(ElevatedButton);

      expect(titleFinder, findsExactly(2));
      expect(hintTextFinder, findsOneWidget);
      expect(promptTextFinder, findsOneWidget);
      expect(textfieldFinder, findsOneWidget);
      expect(elevatedBtnFinder, findsExactly(2));
    });
  });

  testWidgets("Create Album Modal Test", (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: CreateAlbumModal(token: "")));

    final titleFinder = find.text("Create Album");
    final hint1TextFinder = find.text("Album name");
    final hint2TextFinder = find.text("Genre");
    final promptTextFinder = find.text("Pick Thumbnail");
    final textfieldFinder = find.byType(TextField);
    final elevatedBtnFinder = find.byType(ElevatedButton);

    expect(titleFinder, findsOneWidget);
    expect(hint1TextFinder, findsOneWidget);
    expect(hint2TextFinder, findsOneWidget);
    expect(promptTextFinder, findsOneWidget);
    expect(textfieldFinder, findsExactly(3));
    expect(elevatedBtnFinder, findsOne);
  });

  testWidgets("Edit Song Modal Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EditSongModal(
          currentAlbumName: 'old_test_name',
          currentGenre: 'old_test_genre',
          currentDescription: 'old_test_description',
          currentThumbnailPath: '',
        ),
      ),
    );

    final titleFinder = find.text("Edit Album");
    final hint1TextFinder = find.text("Enter new album name");
    final hint2TextFinder = find.text("Enter new genre");
    final hint3TextFinder = find.text("Enter new description");
    final textfieldFinder = find.byType(TextField);
    final elevatedBtnFinder = find.byType(ElevatedButton);

    expect(titleFinder, findsOneWidget);
    expect(hint1TextFinder, findsOneWidget);
    expect(hint2TextFinder, findsOneWidget);
    expect(hint3TextFinder, findsOneWidget);
    expect(textfieldFinder, findsExactly(3));
    expect(elevatedBtnFinder, findsOne);
  });

  testWidgets("Delete Confirmation Modal Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DeleteConfirmationDialog(
          title: "test_title",
          onConfirm: () {},
        ),
      ),
    );

    final text1Finder = find.text("Yes");
    final text2Finder = find.text("No");
    final titleFinder = find.text("test_title");
    final textBtnFinder = find.byType(TextButton);

    expect(text1Finder, findsOneWidget);
    expect(text2Finder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(textBtnFinder, findsExactly(2));
  });

  testWidgets("Modal Heading Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ModalHeadingWidget(
          title: "test_title",
          icon: Icons.text_snippet,
        ),
      ),
    );

    final titleFinder = find.text("test_title");
    final iconFinder = find.byIcon(Icons.text_snippet);

    expect(titleFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
}
