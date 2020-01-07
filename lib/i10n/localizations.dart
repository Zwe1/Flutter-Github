import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'valueMap.dart';

// 主类
class NativeLocalizations {
  final Locale locale;

  NativeLocalizations(this.locale);

  static const _NativeLocalizationsDelegate delegate =
      _NativeLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues =
      localizationsValuesMap;

  // 通过of来调用Localizations of, returnType 可以提示内部方法
  static NativeLocalizations of(BuildContext context) =>
      Localizations.of<NativeLocalizations>(context, NativeLocalizations);

  String _getValue(String k) => _localizedValues[locale.languageCode][k];

  get home => _getValue('home');

  get title => _getValue('title');

  get login => _getValue('login');

  get usernameEmpty => _getValue('username_empty');

  get pwdEmpty => _getValue('pwd_empty');

  get username => _getValue('username');

  get usernamePlaceholder => _getValue('un_placeholder');

  get password => _getValue('pwd');

  get theme => _getValue('theme');

  get language => _getValue('language');

  get lougout => _getValue('lougout');

  get cancel => _getValue('cancel');

  get ok => _getValue('ok');
}

// 实例化localization的delegate类
class _NativeLocalizationsDelegate
    extends LocalizationsDelegate<NativeLocalizations> {
  const _NativeLocalizationsDelegate();

  // 检验是否支持该语言
  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.contains(locale.languageCode);

  // 需要自己实现的load方法
  @override
  Future<NativeLocalizations> load(Locale locale) =>
      SynchronousFuture<NativeLocalizations>(NativeLocalizations(locale));

  // 当Localizations组件重新build时，是否调用load方法加载Locale资源
  @override
  bool shouldReload(_NativeLocalizationsDelegate old) => false;
}
