import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/presentation/screens/admin_home.dart';
import 'package:masinqo/presentation/widgets/admin_tabs.dart';
import 'package:masinqo/presentation/widgets/background.dart';

void main() {
  testWidgets('Admin Home Test', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ListenerBloc("")),
          BlocProvider(create: (_) => ArtistBloc("")),
        ],
        child: const MaterialApp(home: AdminHome(tk: "")),
      ),
    );

    final bgGradientFinder = find.byType(BackgroundGradient);
    final tabFinder = find.byType(DefaultTabController);
    final scaffoldFinder = find.byType(Scaffold);
    final adminTabsFinder = find.byType(AdminTabs);

    expect(bgGradientFinder, findsOneWidget);
    expect(tabFinder, findsOneWidget);
    expect(scaffoldFinder, findsExactly(2));
    expect(adminTabsFinder, findsOneWidget);
  });
}
