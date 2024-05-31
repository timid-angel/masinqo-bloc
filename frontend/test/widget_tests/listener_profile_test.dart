import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_profile/profile_bloc.dart';
import 'package:masinqo/domain/listener/listener_profile.dart';
import 'package:masinqo/presentation/screens/listener_profile.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt_section_title.dart';

void main() {
  group('Artist Profile Test', () {
    testWidgets('Artist Profile Widget Test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ListenerProfile(
            token: '',
            profileBloc:
                ProfileBloc(profileRepository: ListenerProfileCollection()),
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.byType(SectionTitle), findsExactly(2));
      expect(find.byType(RoundedInputField), findsNWidgets(4)); // 2 per section
      expect(find.text('Submit'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Rounded Input Field Test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RoundedInputField(
              placeholder: "Enter new username",
              controller: TextEditingController(),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text("Enter new username"), findsOneWidget);
    });

    testWidgets("Listener Profile Image Test", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListenerProfile(
              token: '',
              profileBloc:
                  ProfileBloc(profileRepository: ListenerProfileCollection()),
            ),
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.image(const AssetImage("assets/images/user.png")),
          findsOneWidget);
    });
  });
}
