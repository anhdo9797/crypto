import 'package:flutter/material.dart';
import 'package:flutter_boiler/app/app.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/constants/colors.dart';

class AppFeedback {
  AppFeedback._();
  static hiddenKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static showSnackbar(String msg, {SnackbarType type = SnackbarType.error}) {
    Widget content = const SizedBox();
    Color? bgColors = type == SnackbarType.error
        ? AppColors.error
        : type == SnackbarType.success
            ? AppColors.success
            : null;

    if (type == SnackbarType.success) {
      content = Text(msg);
    } else {
      content = Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            msg,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ))
        ],
      );
    }

    return App.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: content,
      backgroundColor: bgColors,
    ));
  }
}
