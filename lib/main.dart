import 'package:flutter/material.dart';
import './widgets/randomWords/com.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: new ThemeData(primaryColor: Colors.blueAccent),
        home: new RandomWords());
  }
}
