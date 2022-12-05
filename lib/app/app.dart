import 'package:flutter/material.dart';
import 'package:s_crypto/app/app_config.dart';
import 'package:s_crypto/providers/provider.dart';
import 'package:s_crypto/routes/routes.dart';
import 'package:s_crypto/share/constants/app_language.dart';
import 'package:s_crypto/share/utils/app_localizations.dart';
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
