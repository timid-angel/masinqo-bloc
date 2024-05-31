import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_failures.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
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
  late MockAdminArtistsDataSource mockDataSource;
  late MockAdminArtistsRepository mockRepository;
  late ArtistBloc artistBloc;

  setUp(() {
    mockDataSource = MockAdminArtistsDataSource();
    mockRepository = MockAdminArtistsRepository();
    artistBloc = ArtistBloc(mockRepository as String);
  });

  group('Admin Artists Integration Test', () {
    testWidgets('Admin Artists status is changed', (WidgetTester tester) async {
      final fakeArtists = [
        dto.AdminArtist(id: '1', email: 'artist1@example.com', name: 'Artist 1', isBanned: false, profilePicture: ''),
        dto.AdminArtist(id: '2', email: 'artist2@example.com', name: 'Artist 2', isBanned: true, profilePicture: ''),
      ];

      when(() => mockRepository.getArtists()).thenAnswer((_) async {
        print("Fetching artists from repository...");
        await Future.delayed(const Duration(seconds: 2)); 
        return Right(ArtistFetchSuccess(artists: fakeArtists));
      });

      when(() => mockDataSource.getArtists()).thenAnswer((_) async {
        print("Fetching artists from data source...");
        await Future.delayed(const Duration(seconds: 2)); 
        return http.Response(json.encode(fakeArtists.map((artist) => {
          "_id": artist.id,
          "email": artist.email,
          "name": artist.name,
          "banned": artist.isBanned,
          "profilePicture": artist.profilePicture,
        }).toList()), 200);
      });

      when(() => mockRepository.changeStatus(any())).thenAnswer((invocation) async {
        final artistStatus = invocation.positionalArguments.first as ArtistStatus;
        print("Changing artist status...");
        await Future.delayed(const Duration(seconds: 2)); 
        return artistStatus.newBannedStatus
            ? Right(ArtistStatusChangeSuccess())
            : Left(ArtistStatusChangeFailure(message: "Failed to change status"));
      });

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArtistBloc>(
            create: (context) => artistBloc,
            child: const AdminArtistMGT(),
          ),
        ),
      );

      print("Triggering GetArtists event...");
      artistBloc.add(GetArtists(token: ''));

      await tester.runAsync(() async {
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 2)); 
      });

      print("Checking for artist names in the UI...");
      expect(find.text('Artist 1'), findsOneWidget);
      expect(find.text('artist1@example.com'), findsOneWidget);
      expect(find.text('Artist 2'), findsOneWidget);
      expect(find.text('artist2@example.com'), findsOneWidget);

   
      print("Triggering ChangeArtistStatus event...");
      artistBloc.add(ChangeArtistStatus(
        artistId: '1',
        newBannedStatus: true,
        token: '',
      ));

      await tester.runAsync(() async {
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 2));
      });


      expect(find.text('Unban'), findsOneWidget); 
    });
    
  });
}
