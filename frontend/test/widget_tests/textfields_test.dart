import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/admin_login_textfield.dart'
    as login;
import 'package:masinqo/presentation/widgets/modal_textfield.dart';
import 'package:masinqo/presentation/widgets/signup_textfield.dart' as signup;

void main() {
  group("Textfield Test", () {
    testWidgets("Admin Login Textfield Test", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: login.CustomTextField(
            controller: TextEditingController(),
            hintText: "testing_hinttext",
            prefixIcon: const Icon(Icons.text_snippet),
          ),
        ),
      ));

      final hintTextFinder = find.text("testing_hinttext");
      final iconFinder = find.byIcon(Icons.text_snippet);

      expect(hintTextFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets("Signup Textfield Test", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: signup.CustomTextField(
            controller: TextEditingController(),
            hintText: "testing_hinttext",
            prefixIcon: const Icon(Icons.text_snippet),
            isArtist: true,
          ),
        ),
      ));

      final hintTextFinder = find.text("testing_hinttext");
      final iconFinder = find.byIcon(Icons.text_snippet);

      expect(hintTextFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets("Modal Textfield Test", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModalTextFieldWidget(
              controller: TextEditingController(),
              hintText: "testing_hinttext",
              color: Colors.white,
              lineCount: 1,
              validator: (s) => s,
            ),
          ),
        ),
      );

      final hintTextFinder = find.text("testing_hinttext");

      expect(hintTextFinder, findsOneWidget);
    });
  });
}
