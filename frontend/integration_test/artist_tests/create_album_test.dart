import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/create_album/create_albums_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/presentation/screens/artist_home.dart';
import 'package:masinqo/presentation/widgets/artist_create_album_modal.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumBloc extends Mock implements AlbumBloc {}
class MockArtistHomeBloc extends Mock implements ArtistHomeBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Album Creation Integration Test', () {
    late MockAlbumBloc mockAlbumBloc;
    late MockArtistHomeBloc mockArtistHomeBloc;

    setUp(() {
      mockAlbumBloc = MockAlbumBloc();
      mockArtistHomeBloc = MockArtistHomeBloc();
    });

    tearDown(() {
      mockAlbumBloc.close();
      mockArtistHomeBloc.close();
    });

    testWidgets('Album creation flow', (WidgetTester tester) async {
      whenListen(
        mockAlbumBloc,
        Stream.fromIterable([AlbumLoading(), const AlbumSuccess('Album added successfully')]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArtistHomeBloc>(
            create: (context) => mockArtistHomeBloc,
            child: BlocProvider<AlbumBloc>.value(
              value: mockAlbumBloc,
              child: ArtistHomePage(token: 'test_token'),
            ),
          ),
        ),
      );

      expect(find.byType(ArtistHomePage), findsOneWidget);
      expect(find.text('Create Album'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pumpAndSettle();

      expect(find.byType(CreateAlbumModal), findsOneWidget);
      expect(find.text('Create Album'), findsOneWidget);

      await tester.enterText(find.byKey(Key('Album name')), 'Test Album');
      await tester.enterText(find.byKey(Key('Genre')), 'Test Genre');
      await tester.enterText(find.byKey(Key('Description')), 'Test Description');

     
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      verify(() => mockAlbumBloc.add(any())).called(1);

      // Verify the success message is shown
      expect(find.text('Album added successfully'), findsOneWidget);
    });
  });
}
