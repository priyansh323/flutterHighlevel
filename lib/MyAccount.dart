import 'package:brandly/brandly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var savedNamesCount = (appState.save.length).toString();

    return ListView(
          children: [
            Padding(padding: const EdgeInsets.all(20)),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                 TextSpan(
                  text: 'Your saved Brand Name Total is : $savedNamesCount',
                  style: Theme.of(context).textTheme.displayMedium!,
                 ),
              ],
              ),
              )
          ],

        );
}
}