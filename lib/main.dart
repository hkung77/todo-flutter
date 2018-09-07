import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // render function
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords() 
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();

} 

class RandomWordsState extends State<RandomWords> {
  final _suggestion = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>(); 
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;

        // reach end of the list
        if (index >= _suggestion.length) {
          _suggestion.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestion[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(   // Add the lines from here... 
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),   
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else { 
            _saved.add(pair); 
          } 
        });
      },  
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          return new Scaffold(         // Add 6 lines from here...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );   
        },
      )
    );
  }

 @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold (
      appBar: new AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[     
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ], 
      ),
      body: _buildSuggestions(),
    );
    // return _buildSuggestions();
  }
}