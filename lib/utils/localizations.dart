import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 支持的国际化语言列表
final List<String> supportedLanguage = ['en', 'zh'];

class NativeLocalizations {
  bool isZh = false;

  NativeLocalizations(this.isZh);

  static NativeLocalizations of(BuildContext context) {
    return Localizations.of<NativeLocalizations>(context, NativeLocalizations);
  }

  String get title {
    return isZh ? 'Flutter 应用' : 'Flutter App';
  }
}

// 国际化类
class NativeLocalizationsDelegate
    extends LocalizationsDelegate<NativeLocalizations> {
  const NativeLocalizationsDelegate();

  // 是否支持该语言
  @override
  bool isSupported(Locale locale) =>
      supportedLanguage.contains(locale.languageCode);

  @override
  Future<NativeLocalizations> load(Locale locale) {
    print('load $locale ...');
    return SynchronousFuture<NativeLocalizations>(
        NativeLocalizations(locale.languageCode == 'zh'));
  }

  // 当Localizations组件重新build时，是否调用load方法加载Locale资源
  @override
  bool shouldReload(NativeLocalizationsDelegate old) => false;
}
