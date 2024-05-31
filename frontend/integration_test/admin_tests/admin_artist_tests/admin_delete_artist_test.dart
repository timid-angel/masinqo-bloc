
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart' as dto;
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_datasource.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_success.dart';
import 'package:masinqo/presentation/widgets/admin_artist_mgt.dart';

class MockAdminArtistsRepository extends Mock implements AdminArtistsRepository {}

class MockAdminArtistsDataSource extends Mock implements AdminArtistsDatasource {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockAdminArtistsRepository mockRepository;
  late ArtistBloc artistBloc;

  setUp(() {
    mockRepository = MockAdminArtistsRepository();
    artistBloc = ArtistBloc(mockRepository as String);  
  });

  group('Admin Delete Listener Test', () {
    testWidgets('Artist is deleted and UI updates', (WidgetTester tester) async {
      final fakeArtists = [
        dto.AdminArtist(id: '1', email: 'artist1@example.com', name: 'Artist 1', isBanned: false, profilePicture: ''),
                dto.AdminArtist(id: '2', email: 'artist2@example.com', name: 'Artist 2', isBanned: false, profilePicture: ''),
      ];

      when(() => mockRepository.getArtists()).thenAnswer((_) async => Right(ArtistFetchSuccess(artists: fakeArtists)));
      when(() => mockRepository.deleteArtist('1' as dto.ArtistID)).thenAnswer((_) async => Right(ArtistDeleteSuccess()));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArtistBloc>(
            create: (context) => artistBloc,
            child: const AdminArtistMGT(),
          ),
        ),
      );

      artistBloc.add(GetArtists(token: ''));

      await tester.pumpAndSettle();

      expect(find.text('Artist 1'), findsOneWidget);

      artistBloc.add(DeleteArtist(artistId: '1', token: ''));

      await tester.pumpAndSettle();

      expect(find.text('Artist 1'), findsNothing);
    });
  });
}