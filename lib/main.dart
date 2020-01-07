import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import './widgets/randomWords/com.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/globalVariables.dart';
import 'routes/index.dart';
import 'i10n/index.dart';

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        if (kReleaseMode) {
          exit(1);
        }
      },
      Global.init().then((e) => runApp(new MyApp()))
    };

// void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w;
    try {
      w = MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: ThemeModal(),
            ),
            ChangeNotifierProvider.value(
              value: UserModal(),
            ),
            ChangeNotifierProvider.value(
              value: LocaleModal(),
            ),
            ChangeNotifierProvider.value(
              value: RepoModal(),
            )
          ],
          child: Consumer2<ThemeModal, LocaleModal>(
            builder:
                (BuildContext context, themeModal, localeModal, Widget child) {
              print('modal:=========');
              print(themeModal.theme);
              return MaterialApp(
                theme: ThemeData(primarySwatch: themeModal.theme),
                onGenerateTitle: (context) {
                  // 应用自定义国际化实例
                  return NativeLocalizations.of(context).title;
                },
                // 主页
                home: HomeRoute(),
                locale: localeModal.getLocale(),
                supportedLocales: [
                  Locale('zh', 'CN'),
                  Locale('en', 'US'),
                ],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  NativeLocalizations.delegate,
                ],
                localeListResolutionCallback:
                    (List<Locale> locale, Iterable<Locale> supportedLocales) {
                  if (localeModal.getLocale() != null)
                    return localeModal.getLocale();
                  return Locale('zh', 'CN');
                },
                // 应用路由
                routes: <String, WidgetBuilder>{
                  'login': (context) => LoginRoute(),
                  'themes': (context) => ThemeChangeRoute(),
                  'language': (context) => LanguageRoute(),
                },
              );
            },
          ));
    } catch (e) {
      print('e');
      print(e);
    }

    return w;
  }
}
