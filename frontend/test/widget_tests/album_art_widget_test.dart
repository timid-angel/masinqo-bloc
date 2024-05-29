import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';

void main() {
  testWidgets("Album Art Widget Test", (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: AlbumArt(deviceWidth: 100, albumArt: ""),
    )));

    expect(find.byType(Container), findsOneWidget);
    // expect(find.image(const AssetImage("assets/images/black.png")),
    //     findsOneWidget);
  });
}
