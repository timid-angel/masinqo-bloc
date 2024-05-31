import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/artist_profile_section.dart';

import 'http_override.dart';

void main() {
  testWidgets("Artist Profile Section Test", (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
            body: ArtistProfileSection(
          artistName: '',
          profilePicture: '',
        )),
      ),
    );

    final titleFinder = find.text('Your Albums');
    final scrollWidgetFinder = find.byType(SingleChildScrollView);

    expect(titleFinder, findsOneWidget);
    expect(scrollWidgetFinder, findsOneWidget);
  });
}
