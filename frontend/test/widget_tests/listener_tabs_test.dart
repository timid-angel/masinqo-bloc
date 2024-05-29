import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/listener_tabs.dart';

void main() {
  testWidgets("Listener Tabs Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: BottomNavigationWidget(),
            ),
          ),
        ),
      ),
    );

    final icon1Finder = find.byIcon(Icons.home_filled);
    final icon2Finder = find.byIcon(Icons.favorite_border_outlined);
    final icon3Finder = find.byIcon(Icons.library_music);

    expect(icon1Finder, findsOneWidget);
    expect(icon2Finder, findsOneWidget);
    expect(icon3Finder, findsOneWidget);
  });
}
