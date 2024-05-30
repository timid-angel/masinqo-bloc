// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/presentation/widgets/artist_album_card.dart';
// import 'package:masinqo/temp/models/albums.dart';
// import 'package:masinqo/temp/models/artists.dart';

// void main() {
//   testWidgets("Artist Album Card test", (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: AlbumCard(
//             album: Album(
//                 title: "test_title",
//                 description: "test_desc",
//                 genre: "test_genre",
//                 date: DateTime.now(),
//                 albumArt: "",
//                 artist: Artist(
//                     name: "",
//                     email: "",
//                     password: "",
//                     albums: [],
//                     profilePicture: ""),
//                 songs: []),
//           ),
//         ),
//       ),
//     );

//     final titleFinder = find.text("test_title");
//     final genreFinder = find.text("test_genre");
//     final descFinder = find.text("test_desc");

//     expect(titleFinder, findsOneWidget);
//     expect(genreFinder, findsOneWidget);
//     expect(descFinder, findsOneWidget);
//   });
// }
