import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/i10n/localizations.dart';
import 'package:startup_namer/utils/globalVariables.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NativeLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes
            .map<Widget>((c) => GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Container(
                      color: c,
                      height: 40,
                    ),
                  ),
                  onTap: () {
                    Provider.of<ThemeModal>(context).theme = c;
                    Navigator.of(context).pop();
                  },
                ))
            .toList(),
      ),
    );
  }
}
