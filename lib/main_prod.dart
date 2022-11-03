import 'package:flutter/material.dart';
import 'package:flutter_boiler/app/app.dart';
import 'package:flutter_boiler/app/app_config.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await AppPref.init();
  await dotenv.load(fileName: ".env.prod");

  final configuredApp = AppConfig(
    environment: Environment.prod,
    appTitle: Environment.prod.toAppName,
    child: const App(),
  );

  setup();
  runApp(configuredApp);
}
