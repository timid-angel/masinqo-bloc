import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/listener/listener_album/album_bloc.dart';
import 'package:masinqo/application/listener/listener_album/album_events.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_bloc.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_events.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:mocktail/mocktail.dart';


class MockAlbumBloc extends MockBloc<AlbumEvent, AlbumState> implements AlbumBloc {}
class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState> implements FavoriteBloc {}

class MockBloc<E, S> extends Mock implements Bloc<E, S> {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeAlbumEvent());
    registerFallbackValue(FakeAlbumState());
    registerFallbackValue(FakeFavoriteEvent());
    registerFallbackValue(FakeFavoriteState());
  });

  testWidgets('Display Albums on Listener Home Page', (WidgetTester tester) async {

    final albums = [
      Album(
        id: '1',
        title: 'Album 1',
        albumArt: 'album1.jpg',
        songs: [],
        artist: 'Artist 1',
        description: 'Description 1',
        genre: 'Genre 1',
        date: DateTime.now(),
      ),
      Album(
        id: '2',
        title: 'Album 2',
        albumArt: 'album2.jpg',
        songs: [],
        artist: 'Artist 2',
        description: 'Description 2',
        genre: 'Genre 2',
        date: DateTime.now(),
      ),
    ];


    final albumBloc = MockAlbumBloc();
    final favoriteBloc = MockFavoriteBloc();

    when(() => albumBloc.state).thenReturn(LoadedAlbum(albums));
    whenListen(albumBloc, Stream<AlbumState>.fromIterable([LoadedAlbum(albums)]), initialState: LoadedAlbum(albums));

   
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AlbumBloc>.value(value: albumBloc),
            BlocProvider<FavoriteBloc>.value(value: favoriteBloc),
          ],
          child: const ListenerHome(token: 'dummy_token'),
        ),
      ),
    );

  
    albumBloc.add(FetchAlbums());

    await tester.pumpAndSettle();


    expect(find.text('Album 1'), findsOneWidget);
    expect(find.text('Album 2'), findsOneWidget);
  });
}


class FakeAlbumEvent extends Fake implements AlbumEvent {}
class FakeAlbumState extends Fake implements AlbumState {}
class FakeFavoriteEvent extends Fake implements FavoriteEvent {}
class FakeFavoriteState extends Fake implements FavoriteState {}