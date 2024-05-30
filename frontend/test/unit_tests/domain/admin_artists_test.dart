import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_success.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_failures.dart';

class MockAdminArtistRepository extends Mock implements AdminArtistsRepository {
  @override
  Future<Either<ArtistDeleteFailure, ArtistDeleteSuccess>> deleteArtist(
      ArtistID id) {
    return super.noSuchMethod(
      Invocation.method(#deleteArtist, [id]),
      returnValue: Future.value(Right(ArtistDeleteSuccess())),
      returnValueForMissingStub: Future.value(Right(ArtistDeleteSuccess())),
    );
  }
}

void main() {
  group('AdminArtistsCollection', () {
    final mockAdminArtistsRepository = MockAdminArtistRepository();
    final adminArtistsCollection = AdminArtistsCollection(
        adminArtistsRepository: mockAdminArtistsRepository);

    test('getArtists returns AdminFailure when token is empty', () async {
      when(mockAdminArtistsRepository.token).thenReturn('');

      final result = await adminArtistsCollection.getArtists();
      expect(
          result.fold((l) => l.message, (r) => null), equals("Invalid token"));
    });

    test('deleteArtist returns AdminFailure when token is empty', () async {
      when(mockAdminArtistsRepository.token).thenReturn('');

      final result = await adminArtistsCollection.deleteArtist('testId');
      expect(
          result.fold((l) => l.message, (r) => null), equals("Invalid token"));
    });

    test('changeStatus returns AdminFailure when token is empty', () async {
      when(mockAdminArtistsRepository.token).thenReturn('');

      final result = await adminArtistsCollection.changeStatus('testId', true);
      expect(
          result.fold((l) => l.message, (r) => null), equals("Invalid token"));
    });
  });
}
