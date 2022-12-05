import 'package:flutter/material.dart';
import 'package:s_crypto/app/app.dart';
import 'package:s_crypto/app/app_config.dart';
import 'package:s_crypto/data/local/pref.dart';
import 'package:s_crypto/di/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await AppPref.init();
  await dotenv.load(fileName: ".env.dev");
  SecureAppSwitcher.on(iosStyle: SecureMaskStyle.blurLight);
  setup();

  final configuredApp = AppConfig(
    environment: Environment.dev,
    appTitle: Environment.dev.toAppName,
    child: const App(),
  );
  runApp(configuredApp);
}
