// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/domain/entities/albums.dart';
// import 'package:masinqo/presentation/widgets/listener_album_headline.dart';

// void main() {
//   testWidgets("Listener Album Headline", (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: AlbumHeadlineWidget(
//             album: Album(
//               title: "test_title",
//               description: "test_desciption",
//               genre: "test_genre",
//               date: DateTime.now(),
//               albumArt: "",
//               artist: "",
//               songs: [],
//             ),
//           ),
//         ),
//       ),
//     );

//     final titleFinder = find.text("test_title");

//     expect(titleFinder, findsOneWidget);
//   });
// }
