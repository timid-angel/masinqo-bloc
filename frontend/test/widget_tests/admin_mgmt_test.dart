import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:masinqo/application/admin/admin_bloc.dart";
import "package:masinqo/presentation/widgets/admin_artist_mgt.dart";
import "package:masinqo/presentation/widgets/admin_empty_list.dart";
import "package:masinqo/presentation/widgets/admin_header.dart";
import "package:masinqo/presentation/widgets/admin_listener_mgt.dart";

void main() {
  group("Admin Management Tests", () {
    testWidgets("Admin Artist Management Widget Test", (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider(create: (context) => ArtistBloc(""))],
          child: const MaterialApp(home: AdminArtistMGT()),
        ),
      );

      final titleFinder = find.text("Artists");
      final headerFinder = find.text("Masinqo");

      expect(titleFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
    });

    testWidgets("Admin Listener Management Widget Test", (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ListenerBloc("")),
          ],
          child: const MaterialApp(home: AdminListenerMGT()),
        ),
      );

      final titleFinder = find.text("Listeners");
      final headerFinder = find.byType(AdminHeader);

      expect(titleFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
    });

    testWidgets("Empty list tester", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AdminEmptyList()));

      final emptyListFinder = find.byType(Container);

      expect(emptyListFinder, findsOneWidget);
    });
  });
}
