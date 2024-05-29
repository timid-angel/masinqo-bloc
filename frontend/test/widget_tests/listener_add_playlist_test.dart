import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/listener_add_playlist.dart';
import 'package:masinqo/presentation/widgets/modal_button.dart';
import 'package:masinqo/presentation/widgets/modal_heading.dart';

void main() {
  group("Listener Add Playlist Test", () {
    testWidgets('Add Playlist Widget Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddPlaylistWidget(token: ""),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ModalHeadingWidget), findsOneWidget);
      expect(find.text('New Playlist'), findsOneWidget);
      expect(find.text('Playlist Name'), findsOneWidget);
      expect(find.byType(ModalButtonWidget), findsOneWidget);
      expect(find.text('Create Playlist'), findsOneWidget);
    });
  });
}
