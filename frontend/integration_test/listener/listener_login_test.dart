import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:masinqo/main.dart'as app;


void main(){
group("ListenerLogin Test",()
{
IntegrationTestWidgetsFlutterBinding.ensureInitialized();
testWidgets('Login Testing Widgets', (tester)async{
  app.main();
  await tester.pumpAndSettle();
  final artistOption = find.byKey(Key("asListenerOption"));
    await tester.tap(artistOption);
    await tester.pumpAndSettle();

await tester.enterText(find.byKey(Key('emailField')), 'mem@gmail.com');
await tester.enterText(find.byKey(Key('passwordField')), '1234567');
 final loginButton = find.byKey(Key("alLoginButton"));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

});

} );

}








