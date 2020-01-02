import 'package:flutter/material.dart';
// import './widgets/randomWords/com.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';
import 'utils/globalVariables.dart';
import 'routes/index.dart';

void main() => Global.init().then((e) => runApp(new MyApp()));

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
            )
          ],
          child: Consumer2<ThemeModal, LocaleModal>(
            builder:
                (BuildContext context, themeModal, localeModal, Widget child) {
              return MaterialApp(
                theme: ThemeData(primarySwatch: themeModal.theme),
                // onGenerateTitle: (context) {
                //   return Localizations.of(context, null).title;
                // },
                // 主页
                home: HomeRoute(),
                // locale: localeModal.getLocale(),
                // supportedLocales: [
                //   Locale('en', 'US'),
                //   Locale('zh', 'CN'),
                // ],
                // localizationsDelegates: [
                //   GlobalMaterialLocalizations.delegate,
                //   GlobalWidgetsLocalizations.delegate,
                // ],
                // localeListResolutionCallback:
                //     (List<Locale> locale, Iterable<Locale> supportedLocales) {
                //   if (localeModal.getLocale() != null)
                //     return localeModal.getLocale();
                //   if (supportedLocales.contains(locale[0])) {
                //     return locale[0];
                //   }
                //   return Locale('en', 'US');
                // },
                // 应用路由
                routes: <String, WidgetBuilder>{
                  'login': (context) => LoginRoute(),
                  'themes': (context) => ThemeChangeRoute(),
                  'locale': (context) => LanguageRoute(),
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
