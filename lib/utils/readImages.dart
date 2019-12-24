library image_reader;

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageReader extends StatefulWidget {
  @override
  _ImageReaderState createState() => new _ImageReaderState();
}

class _ImageReaderState extends State<ImageReader> {
  int _counter;

  // 初始化
  @override
  Future<void> initState() async {
    super.initState();
    try {
      int value = await _readCounter();
      setState(() {
        _counter = value;
      });
    } catch (err) {}
  }

  // 获取文件目录
  Future<File> _getLocalImages() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print('app path');
    print(dir);
    return new File('$dir/counter.txt');
  }

  // 读取文件内容
  Future<int> _readCounter() async {
    try {
      File file = await _getLocalImages();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocalImages()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('image reader'),
      ),
      body: new Center(
        child: new Text('tapped $_counter time${_counter == 1 ? '' : 's'}'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
