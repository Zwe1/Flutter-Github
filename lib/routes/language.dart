import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/i10n/index.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localModal = Provider.of<LocaleModal>(context);
    // var lz = Localizations.of(context, null);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localModal.locale == value ? color : null),
        ),
        trailing:
            localModal.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          localModal.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(NativeLocalizations.of(context).language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
        ],
      ),
    );
  }
}
