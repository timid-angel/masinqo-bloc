// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/presentation/widgets/artist_drawer.dart';
// import 'package:masinqo/presentation/widgets/listener_drawer.dart';

// void main() {
//   group("Drawers Test", () {
//     testWidgets("Artist Drawer Test", (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(body: ArtistDrawer()),
//         ),
//       );

//       final profilemgmtFinder = find.text('Profile Management');
//       final logoutFinder = find.text('Logout');
//       final avatarFinder = find.byType(CircleAvatar);

//       expect(profilemgmtFinder, findsOneWidget);
//       expect(logoutFinder, findsOneWidget);
//       expect(avatarFinder, findsOneWidget);
//     });

//     testWidgets("Listener Drawer Test", (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(body: ListenerDrawer()),
//         ),
//       );

//       final profilemgmtFinder = find.text('Profile Management');
//       final logoutFinder = find.text('Logout');
//       final avatarFinder = find.byType(CircleAvatar);

//       expect(profilemgmtFinder, findsOneWidget);
//       expect(logoutFinder, findsOneWidget);
//       expect(avatarFinder, findsOneWidget);
//     });
//   });
// }
