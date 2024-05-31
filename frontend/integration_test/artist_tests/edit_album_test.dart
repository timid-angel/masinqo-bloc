import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/album/album_event.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/application/artists/home_page/artist_home_state.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

 setUpAll(() {
  registerFallbackValue(FakeAlbumEvent());
  registerFallbackValue(FakeAlbumState());
  registerFallbackValue(FakeArtistHomeEvent()); // Add this line
});


  testWidgets('Edit Album Integration Test', (WidgetTester tester) async {
    final mockAlbumBloc = MockAlbumBloc();
    final mockArtistHomeBloc = MockArtistHomeBloc();

    // Mock initial album state
    final initialAlbumState = AlbumState(
      title: 'Initial Title',
      albumArt: 'Initial Art',
      songs: [],
      artist: 'Initial Artist',
      description: 'Initial Description',
      genre: 'Initial Genre',
      date: DateTime.now(),
      error: '',
      albumId: '1',
    );

    when(() => mockAlbumBloc.state).thenReturn(initialAlbumState);

    // Set up mock responses for album update
    when(() => mockAlbumBloc.add(any())).thenAnswer((_) async {});
    when(() => mockArtistHomeBloc.add(any())).thenAnswer((_) async {});

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

    // Verify initial album state displayed
    expect(find.text('Initial Title'), findsOneWidget);

    // Open the edit album modal
    await tester.tap(find.text('Edit Album'));
    await tester.pumpAndSettle();

    // Verify that the modal is opened
    expect(find.byType(Dialog), findsOneWidget);

    // Edit album details
    await tester.enterText(find.byKey(Key('title_field')), 'Edited Title');
    await tester.enterText(find.byKey(Key('genre_field')), 'Edited Genre');
    await tester.enterText(find.byKey(Key('description_field')), 'Edited Description');
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    // Verify that the AlbumUpdateEvent was dispatched
    verify(() => mockAlbumBloc.add(
      AlbumUpdateEvent(
        title: 'Edited Title',
        genre: 'Edited Genre',
        description: 'Edited Description',
      ),
    )).called(1);

    // Verify that the album state is updated
    expect(
      (mockAlbumBloc.state as AlbumState).title,
      equals('Edited Title'),
    );
    expect(
      (mockAlbumBloc.state as AlbumState).genre,
      equals('Edited Genre'),
    );
    expect(
      (mockAlbumBloc.state as AlbumState).description,
      equals('Edited Description'),
    );
  });
}

class MockAlbumBloc extends MockBloc<AlbumEvent, AlbumState> implements AlbumBloc {}

class MockArtistHomeBloc extends MockBloc<ArtistHomeEvent, ArtistHomeState> implements ArtistHomeBloc {}

class FakeAlbumEvent extends Fake implements AlbumEvent {}

class FakeAlbumState extends Fake implements AlbumState {}
class FakeArtistHomeEvent extends Fake implements ArtistHomeEvent {}
