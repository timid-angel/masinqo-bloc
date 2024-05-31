import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/screens/artist_home.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeAlbumEvent());
    registerFallbackValue(FakeAlbumState());
  });

  testWidgets('Delete Album Integration Test', (WidgetTester tester) async {
    final dummyAlbum = Album(
      id: '1',
      title: 'Dummy Album',
      artist: 'Dummy Artist',
      albumArt: 'sample_album_art',
      songs: [],
      description: 'This is a description',
      genre: 'genre',
      date: DateTime.now(),
    );

    final mockAlbumBloc = MockAlbumBloc();
    final mockArtistHomeBloc = MockArtistHomeBloc();

    when(() => mockAlbumBloc.state).thenReturn(AlbumLoaded(
      album: dummyAlbum,
      title: 'Dummy Album',
      albumArt: 'sample path',
      songs: [],
      description: 'this is a description',
      genre: 'genre',
      date: DateTime.now(),
      artist: 'Dummy Artist',
      error: '',
      albumId: '1',
    ));

    whenListen(
      mockAlbumBloc,
      Stream.fromIterable([
        AlbumLoaded(
          album: dummyAlbum,
          title: 'Dummy Album',
          albumArt: 'sample path',
          songs: [],
          description: 'this is a description',
          genre: 'genre',
          date: DateTime.now(),
          artist: 'Dummy Artist',
          error: '',
          albumId: '1',
        ),
        // Add more states if necessary to simulate state transitions
      ]),
    );

    when(() => mockAlbumBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AlbumBloc>.value(value: mockAlbumBloc),
            BlocProvider<ArtistHomeBloc>.value(value: mockArtistHomeBloc),
          ],
          child: ArtistsAlbumPage(
            blocTransferObject: BlocTransferObject(
              artistHomeBloc: mockArtistHomeBloc,
              albumBloc: mockAlbumBloc,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Dummy Album'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('delete_album_button')));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();

    verify(() => mockAlbumBloc.add(any(that: isA<DeleteAlbumEvent>()))).called(1);

    expect(find.byType(ArtistHomePage), findsOne);
  });
}

class AlbumLoaded extends AlbumState {
  final Album album;

  AlbumLoaded({
    required this.album,
    required String title,
    required String albumArt,
    required List<Song> songs,
    required String description,
    required String genre,
    required DateTime date,
    required String artist,
    required String error,
    required String albumId,
  }) : super(
          title: title,
          albumArt: albumArt,
          songs: songs,
          description: description,
          genre: genre,
          date: date,
          artist: artist,
          error: error,
          albumId: albumId,
        );
}

class MockAlbumBloc extends Mock implements AlbumBloc {}

class MockArtistHomeBloc extends Mock implements ArtistHomeBloc {}

class FakeAlbumEvent extends Fake implements AlbumEvent {}

class FakeAlbumState extends Fake implements AlbumState {}
