import 'package:brandly/brandly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedNames extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if(appState.save.isEmpty){
      return Center(
        child: Text('You Dont have any Brand Name ideas yet'),
      );
    }

    return ListView(
        children: [
          Padding(padding: const EdgeInsets.all(20)),
          Text('Your Saved Brand Names '),
          for(var na in appState.save)
           ListTile(
            leading: Icon(Icons.favorite),
            title: Text(na.asLowerCase),
           )
      ],
      );
  }
}