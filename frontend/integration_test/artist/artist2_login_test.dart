import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/main.dart'as app;


void main(){
group("Artist Login Test",()
{
IntegrationTestWidgetsFlutterBinding.ensureInitialized();
testWidgets('Login Testing Widgets', (tester)async{
  app.main();
  await tester.pumpAndSettle();
  final artistOption = find.byKey(Key("asArtistOption"));
    await tester.tap(artistOption);
    await tester.pumpAndSettle();

await tester.enterText(find.byKey(Key('emailField')), 'kb@gmail.com');
await tester.enterText(find.byKey(Key('passwordField')), '1234567');
 final loginButton = find.byKey(Key("alLoginButton"));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

});

} );

}








