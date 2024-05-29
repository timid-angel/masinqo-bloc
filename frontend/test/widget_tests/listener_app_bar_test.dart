import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';

void main() {
  testWidgets("Listener App Bar Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) {
                return [
                  const ListenerAppbar(),
                ];
              },
              body: const Placeholder()),
        ),
      ),
    );

    final logoFinder = find.image(const AssetImage('assets/images/logo.png'));
    final titleFinder = find.text('Masinqo');

    expect(logoFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
  });
}
