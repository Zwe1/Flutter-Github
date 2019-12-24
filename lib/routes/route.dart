library route;

import 'package:flutter/material.dart';

class Route extends StatelessWidget {
  final AppBar appBar;
  final Object body;
  final Function actions;

  Route(this.appBar, this.body, this.actions);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
