import 'package:flutter/material.dart';
import 'package:startup_namer/models/index.dart';
import 'package:startup_namer/utils/globalVariables.dart';

// 通知基类
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

// 切换用户
class UserModal extends ProfileChangeNotifier {
  User get user => profile.user;

  set user(User user) {
    if (user?.login != profile.user.login) {
      profile.lastLogin = profile.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }

  bool get isLogin => user != null;
}

// 切换主题
class ThemeModal extends ProfileChangeNotifier {
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == profile.theme, orElse: () => Colors.blue);

  set theme(ColorSwatch color) {
    if (color != theme) {
      profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

// 切换语言
class LocaleModal extends ProfileChangeNotifier {
  Locale getLocale() {
    if (profile.locale == null) return null;
    var t = profile.locale.split('_');
    return Locale(t[0], t[1]);
  }

  String get locale => profile.locale;

  set locale(String locale) {
    if (locale != profile.locale) {
      profile.locale = locale;
      notifyListeners();
    }
  }
}
