import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'BRANDLY',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(234, 18, 118, 7)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var save =<WordPair>[];

  void saveBrand(){
    if(save.contains(current)){
      save.remove(current);
    }
    else{
      save.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var  selectedIndex = 0;

 @override
  Widget build(BuildContext context) {
    Widget page;
      switch (selectedIndex) {
       case 0:
        page = GeneratorPage();
        break;
       case 1:
        page = SavedNames();
        break;
       case 2:
        page = MyAccount();
        break;
       default:
        throw UnimplementedError('no widget for $selectedIndex');
}

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child : NavigationRail( 
            extended: false,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home')),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_outlined),
                label: Text('Saved Names')),
              NavigationRailDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: Text('My Account')),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value){
              setState((){
                selectedIndex=value;
              });
            },
          ),
          ),
          Expanded(
           child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
           ),
          ),
        ],
      )
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var brandName = appState.current;

    IconData saveIcon;
    if(appState.save.contains(brandName)){
        saveIcon = Icons.favorite;
    }
    else{
      saveIcon = Icons.favorite_border;
    }

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text : 'Get Name For Your ',
                style: Theme.of(context).textTheme.displayLarge!,
                children: const <TextSpan>[
                 TextSpan(text: 'BRAND', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            ),
            BigCard(brandName: brandName),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.saveBrand();
                  },
                  icon: Icon(saveIcon),
                  label: Text('Save Name'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next Brand Name'),
                ),
              ],
            ),
          ],
        ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.brandName,
  });

  final WordPair brandName;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayLarge!.copyWith(
      color: Color.fromARGB(234, 120, 123, 79),
    );
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Text(brandName.asPascalCase, style:style),
    );
  }
}

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
                  text: 'Your saved Brand Name Total is : ${savedNamesCount}',
                  style: Theme.of(context).textTheme.displayLarge!,
                 ),
              ],
              ),
              )
          ],

        );
}
}