import 'package:flutter/material.dart';
import 'package:flutter_boiler/app/app_config.dart';
import 'package:flutter_boiler/providers/provider.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/app_language.dart';
import 'package:flutter_boiler/share/utils/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: "scaffoldMessengerKey");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider<LangProvider>(create: (_) => LangProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: ((context) {
          final langProvider =
              Provider.of<LangProvider>(context, listen: false);

          return MaterialApp.router(
            title: AppConfig.of(context).appTitle,
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerConfig: AppRouter.routes,
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeProvider>().theme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(
              context.read<LangProvider>().locale,
              langProvider.getCode(),
            ),
            supportedLocales: AppLanguage.supportLocale,
          );
        }),
      ),
    );
  }
}
