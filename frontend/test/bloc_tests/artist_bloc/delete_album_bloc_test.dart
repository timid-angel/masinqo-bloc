// import 'package:flutter/material.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/application/artists/create_album/create_albums_state.dart';
// import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
// import 'package:masinqo/domain/artists/artists.dart';
// import 'package:masinqo/domain/artists/artists_failure.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:masinqo/application/artists/album/album_bloc.dart';
// import 'package:masinqo/application/artists/album/album_event.dart';
// import 'package:masinqo/application/artists/album/album_state.dart';
// import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
// import 'package:go_router/go_router.dart';

// class MockArtistEntity extends Mock implements ArtistEntity {}

// class MockArtistHomeBloc extends Mock implements ArtistHomeBloc {}

// class MockBuildContext extends Mock implements BuildContext {}
// void main() {
//   late MockArtistEntity mockArtistEntity;
//   late MockArtistHomeBloc mockArtistHomeBloc;
//   late MockBuildContext mockBuildContext;
//   late AlbumBloc albumBloc;
//   const token = 'test_token';
//   const albumId = 'album_123';

//   setUp(() {
//     mockArtistEntity = MockArtistEntity();
//     mockArtistHomeBloc = MockArtistHomeBloc();
//     mockBuildContext = MockBuildContext();
//     albumBloc = AlbumBloc(
//       token: token,
//       album: AlbumState(
//         title: 'Old Title',
//         albumArt: 'Old Art',
//         artist: 'Old Artist',
//         date: DateTime.now(),
//         description: 'Old Description',
//         error: '',
//         genre: 'Old Genre',
//         songs: [],
//         albumId: albumId,
//       ),
//     );

//     // Mock goNamed method
//     when(() => mockBuildContext.goNamed(any(), pathParameters: any(named: 'pathParameters'))).thenReturn(null);
//   });

//   tearDown(() {
//     albumBloc.close();
//   });

//   group('AlbumBloc', () {
//     blocTest<AlbumBloc, AlbumState>(
//       'emits state with isDeleted = true when DeleteAlbumEvent is successful',
//       build: () {
//         when(() => mockArtistEntity.removeAlbum(any())).thenAnswer(
//           (_) async => Right(unit),
//         );
//         return AlbumBloc(token: token, album: albumBloc.state);
//       },
//       act: (bloc) => bloc.add(DeleteAlbumEvent(
//         albumId: albumId,
//         artistHomeBloc: mockArtistHomeBloc,
//         context: mockBuildContext,
//       )),
//       expect: () => [
//         albumBloc.state.copyWith(isDeleted: true, error: ''),
//       ],
//       verify: (_) {
//         verify(() => mockArtistEntity.removeAlbum(albumId)).called(1);
//         verify(() => mockArtistHomeBloc.add(RemoveDeletedAlbum(albumId: albumId))).called(1);
//         verify(() => mockBuildContext.goNamed("artist", pathParameters: {"token": mockArtistHomeBloc.token})).called(1);
//       },
//     );

//     blocTest<AlbumBloc, AlbumState>(
//       'emits state with error message when DeleteAlbumEvent fails',
//       build: () {
//         when(() => mockArtistEntity.removeAlbum(any())).thenAnswer(
//           (_) async => Left(AlbumFailure( 'Deletion failed') as ArtistEntityFailure),
//         );
//         return AlbumBloc(token: token, album: albumBloc.state);
//       },
//       act: (bloc) => bloc.add(DeleteAlbumEvent(
//         albumId: albumId,
//         artistHomeBloc: mockArtistHomeBloc,
//         context: mockBuildContext,
//       )),
//       expect: () => [
//         albumBloc.state.copyWith(error: 'Deletion failed'),
//       ],
//       verify: (_) {
//         verify(() => mockArtistEntity.removeAlbum(albumId)).called(1);
//       },
//     );
//   });
// }