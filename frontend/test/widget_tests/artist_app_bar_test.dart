import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/artist_app_bar.dart';

void main() {
  testWidgets("Artist App Bart Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ArtistAppBar()),
      ),
    );

    final logoFinder = find.image(const AssetImage('assets/images/logo.png'));
    final titleFinder = find.text('Masinqo');
    final icon1Finder = find.byIcon(Icons.home);
    final icon2Finder = find.byIcon(Icons.menu);

    expect(logoFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(icon1Finder, findsOneWidget);
    expect(icon2Finder, findsOneWidget);
  });
}
