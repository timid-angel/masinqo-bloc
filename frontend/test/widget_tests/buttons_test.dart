import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';

void main() {
  group("Buttons Test", () {
    testWidgets("Admin Login Button Test", (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: CustomElevatedButton(
              onPressed: () {}, buttonText: "testing_text")));

      final textFinder = find.text("testing_text");

      expect(textFinder, findsOneWidget);
    });
  });
}
