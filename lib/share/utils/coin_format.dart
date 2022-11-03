import 'package:flutter/material.dart';

import 'package:flutter_boiler/share/constants/colors.dart';

String formatPercentage(num? value) {
  if (value == null) return "";

  return "${value.toStringAsFixed(2).replaceAll("-", "")}%";
}

Color getColorPercentage(num? value) {
  if (value == null) return Colors.white;
  if (value > 0) return AppColors.success;

  return AppColors.error;
}
