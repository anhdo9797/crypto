import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/string.dart';

enum Environment { dev, prod }

extension EnvironmentExtension on Environment {
  String get toAppName {
    switch (this) {
      case Environment.dev:
        return "${AppString.appName} [dev]";
      default:
        return AppString.appName;
    }
  }
}

class AppConfig extends InheritedWidget {
  final Environment environment;
  final String appTitle;

  const AppConfig({
    Key? key,
    required Widget child,
    required this.environment,
    required this.appTitle,
  }) : super(
          key: key,
          child: child,
        );

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
