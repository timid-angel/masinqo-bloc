// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/domain/entities/albums.dart';
// import 'package:masinqo/presentation/widgets/listener_album_headline.dart';

<<<<<<< HEAD
void main() {
  testWidgets("Listener Album Headline", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AlbumHeadlineWidget(
            album: Album(
              title: "testing_title",
              description: "test_desciption",
              genre: "test_genre",
              date: DateTime.now(),
              albumArt: "",
              artist: "",
              songs: [],
              id: '',
            ),
          ),
        ),
      ),
    );
=======
// void main() {
//   testWidgets("Listener Album Headline", (tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: AlbumHeadlineWidget(
//             album: Album(
//               title: "testing_title",
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
>>>>>>> 051696d3559517c4c88ce9cdfc44f5be65ee27b7

//     expect(find.byIcon(Icons.favorite), findsOneWidget);
//     await tester.tap(find.byType(GestureDetector));
//     await tester.pump();
//     expect(find.byIcon(Icons.favorite_border_outlined), findsOneWidget);
//   });
// }
