import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/admin_tabs.dart';

void main() {
  testWidgets("Admin Tabs Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: AdminTabs(),
            ),
          ),
        ),
      ),
    );

    final icon1Finder = find.byIcon(Icons.headset);
    final icon2Finder = find.byIcon(Icons.person);

    expect(icon1Finder, findsOneWidget);
    expect(icon2Finder, findsOneWidget);
  });
}
