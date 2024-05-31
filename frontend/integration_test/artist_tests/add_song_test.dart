import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/widgets/artist_add_song_modal.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

setUpAll(() {
  registerFallbackValue(FakeAlbumEvent());
  registerFallbackValue(FakeAlbumState());
  registerFallbackValue(FakeArtistHomeEvent()); 
});


  testWidgets('Add Song Integration Test', (WidgetTester tester) async {
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

  
    await tester.tap(find.text('Add Song'));
    await tester.pumpAndSettle();


    expect(find.byType(AddSongModal), findsOneWidget);


    await tester.enterText(find.byKey(const Key('song_name_field')), 'New Song');
    await tester.enterText(find.byKey(const Key('song_file_path_field')), '/path/to/song.mp3');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

  
    verify(() => mockAlbumBloc.add(
      AddSongEvent(
        songName: 'New Song',
        songFilePath: '/path/to/song.mp3',
      ),
    )).called(1);

  
    expect(mockAlbumBloc.state.songs.any((song) => song.name == 'New Song'), true);
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
class FakeArtistHomeEvent extends Fake implements ArtistHomeEvent {}
