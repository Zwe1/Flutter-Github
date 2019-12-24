library state;

import './com.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _pushRoute() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      final tiles = _saved.map((pair) {
        return new ListTile(
            title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ));
      });

      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Suggestions'),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushRoute,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (ctx, i) {
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(5));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    print('$pair ${pair.runtimeType}');
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
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
}
