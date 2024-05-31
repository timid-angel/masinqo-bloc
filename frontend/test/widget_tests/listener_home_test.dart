import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/domain/listener/listener_album.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'http_override.dart';

void main() {
  testWidgets("Listener Home Test", (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(BlocProvider(
      create: (context) =>
          FavoriteBloc(favoriteRepository: ListenerFavCollection()),
      child: MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => AlbumBloc(
                        albumCollection: ListenerAlbumCollection(),
                      ))
            ],
            child: const ListenerHome(
              token: '',
            ),
          ),
        ),
      ),
    ));

    expect(find.text("Albums"), findsOneWidget);
    expect(find.text("No Albums available"), findsOneWidget);
  });
}
