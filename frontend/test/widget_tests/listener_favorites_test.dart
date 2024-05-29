import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';

void main() {
  testWidgets('Listener Favorites Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FavoriteBloc>(
          create: (context) =>
              FavoriteBloc(favoriteRepository: ListenerFavCollection()),
          child: const ListenerFavorites(token: ""),
        ),
      ),
    );

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text("No Favorites available"), findsOneWidget);
  });
}
