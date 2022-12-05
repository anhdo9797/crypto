import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';

extension TypographyUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme; // Modify this line
  ColorScheme get colors => theme.colorScheme;

  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: colors.onSurface,
      );
  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: colors.onSurface,
      );
  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith(
        color: colors.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith(
        color: colors.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(
        color: colors.onSurface,
      );
  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(
        color: colors.onSurface,
      );
  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(
        color: colors.onSurface,
        fontSize: 12,
      );

  SizeConfig get sizeConfig => SizeConfig();
}
