import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';

void main() {
  testWidgets("Admin Header Widget Test", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AdminHeader()));

    final titleFinder = find.text('Masinqo');
    final logoFinder = find.image(const AssetImage("assets/images/logo.png"));
    final logoutButton = find.byIcon(Icons.logout);

    expect(titleFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(logoutButton, findsOneWidget);
  });
}
