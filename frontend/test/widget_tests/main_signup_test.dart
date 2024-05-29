import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/screens/signup.dart';

void main() {
  testWidgets("Main Signup Page Test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SignupWidget()),
    ));

    final signupArtistBtn = find.text('Artist Signup');
    final signupListenerBtn = find.text('Listener Signup');

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Container), findsExactly(2));
    expect(find.text('Masinqo'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text("Signup"), findsOneWidget);
    expect(signupArtistBtn, findsOneWidget);
    expect(signupListenerBtn, findsOneWidget);
    expect(find.byType(TextButton), findsExactly(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color,
        AppColors.artist2);

    await tester.tap(signupListenerBtn);
    await tester.pump();
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color,
        AppColors.listener4);

    await tester.tap(signupArtistBtn);
    await tester.pump();
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color,
        AppColors.artist2);
  });
}
