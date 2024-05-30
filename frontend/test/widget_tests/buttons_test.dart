import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/auth/login_page_bloc.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_buttons.dart';
import 'package:masinqo/presentation/widgets/login_options.dart';

void main() {
  group("Buttons Test", () {
    testWidgets("Admin Login Button Test", (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: CustomElevatedButton(
              onPressed: () {}, buttonText: "testing_text")));

      final textFinder = find.text("testing_text");

      expect(textFinder, findsOneWidget);
    });
  });

  testWidgets("Login Options Button Test", (tester) async {
    final bloc = LoginPageBloc();
    final testTarget = LoginOptionButton(
      buttonText: "testing_text",
      isArtist: false,
      loginBloc: bloc,
      primaryColor: Colors.white,
      toValue: false,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: testTarget,
      ),
    );

    final textFinder = find.text("testing_text");
    final initVal = testTarget.isArtist;
    expect(initVal, false);
    expect(textFinder, findsOneWidget);
  });

  // testWidgets("Playlist Buttons Test", (tester) async {
  //   final testTarget = PlaylistButtonsWidget(
  //       editController: () {},
  //       deleteController: () {},
  //       playlistName: "test_plname");
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: testTarget,
  //     ),
  //   );

  //   final editFinder = find.text("Edit");
  //   final deleteFinder = find.text("Delete");
  //   final initialPl =
  //       find.text('Are you sure you want to delete this playlist?');
  //   await tester.tap(deleteFinder);
  //   await tester.pump();
  //   final finalPl = find.text('Are you sure you want to delete this playlist?');

  //   expect(initialPl, findsOneWidget);
  //   expect(finalPl, findsOneWidget);
  //   expect(editFinder, findsOneWidget);
  //   expect(deleteFinder, findsOneWidget);
  // });
}
