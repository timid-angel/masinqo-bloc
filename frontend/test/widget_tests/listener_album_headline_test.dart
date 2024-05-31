import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
import 'http_override.dart';

void main() {
  testWidgets("Listener Album Headline", (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      BlocProvider(
        create: (context) =>
            FavoriteBloc(favoriteRepository: ListenerFavCollection()),
        child: MaterialApp(
          home: Scaffold(
            body: AlbumHeadlineWidget(
              album: Album(
                title: "testing_title",
                description: "test_desciption",
                genre: "test_genre",
                date: DateTime.now(),
                albumArt: "",
                artist: "",
                songs: [],
                id: '',
              ),
              token: '',
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(find.text("0 tracks"), findsOneWidget);
  });
}
