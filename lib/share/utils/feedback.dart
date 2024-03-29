import 'package:flutter/material.dart';
import 'package:s_crypto/app/app.dart';
import 'package:s_crypto/share/constants/app_type.dart';
import 'package:s_crypto/share/constants/colors.dart';

class AppFeedback {
  AppFeedback._();
  static hiddenKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static showSnackbar(String msg, {SnackbarType type = SnackbarType.error}) {
    Widget content = const SizedBox();
    Color? bgColors = type == SnackbarType.error
        ? errorColor
        : type == SnackbarType.success
            ? successColor
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
