import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:masinqo/presentation/widgets/admin_artist_mgt.dart";

void main() {
  testWidgets("Admin Artist Management Widget Test", (tester) async {
    await tester.pumpWidget(const AdminArtistMGT());

    final titleFinder = find.text("Artists");
    final headerFinder = find.text("Masinqo");
    final emptyListFinder =
        find.image(const AssetImage("assets/images/empty_list.png"));

    expect(titleFinder, findsOneWidget);
    expect(headerFinder, findsOneWidget);
    expect(emptyListFinder, findsOneWidget);
  });
}
