import 'package:brandly/brandly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:brandly/brandly.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Brandly Integration Tests', () {
    testWidgets('HomePage Functionality Test', (captain) async{
      app.main();
      await captain.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(GeneratorPage), findsOneWidget);
      
      final iconsHomePage = [
        'saveIcon',
        'home',
        'favorite_outlined',
        'account_circle_outlined'
      ];

      for(var ico in iconsHomePage){
        await captain.tap(find.byKey(ValueKey(ico)));
        await captain.pumpAndSettle(const Duration(seconds: 1));
      }

      expect(find.text('Get Name For Your BRAND'),findsOneWidget);

      expect(find.byKey(Key('NextButton')),findsOneWidget);
    },
    );
   },
   );
}