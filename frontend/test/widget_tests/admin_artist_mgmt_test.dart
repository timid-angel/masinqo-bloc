import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:masinqo/application/admin/admin_bloc.dart";
import "package:masinqo/presentation/widgets/admin_artist_mgt.dart";
import "package:masinqo/presentation/widgets/admin_empty_list.dart";

void main() {
  group("Admin Artist Management Tests", () {
    testWidgets("Admin Artist Management Widget Test", (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider(create: (context) => ArtistBloc())],
          child: const MaterialApp(home: AdminArtistMGT()),
        ),
      );

      final titleFinder = find.text("Artists");
      final headerFinder = find.text("Masinqo");

      expect(titleFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
    });

    testWidgets("Empty list tester", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AdminEmptyList()));

      final emptyListFinder = find.byWidget(Center());
      // find.image(AssetImage("assets/images/empty_list.png"));

      expect(emptyListFinder, findsOneWidget);
    });
  });
}
