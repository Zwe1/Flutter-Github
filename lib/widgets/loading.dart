import 'package:flutter/material.dart';

class Loading extends Dialog {
  String text;
  Loading(this.text);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 120,
          height: 120,
          child: new Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: new Text(text),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
