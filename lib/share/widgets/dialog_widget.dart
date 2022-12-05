import 'package:flutter/material.dart';
import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/utils/app_localizations.dart';
import 'package:s_crypto/share/utils/size_config.dart';

enum DialogType {
  warning,
  success,
  error,
}

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    required this.title,
    this.onOk,
    this.onCancel,
    this.message,
    this.textCancel,
  }) : super(key: key);

  final String title;
  final String? message;
  final String? textCancel;
  final Function()? onOk;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig();
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(color: colorScheme.background),
          height: size.screenHeight * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: colorScheme.onBackground,
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    message ?? "",
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
              _buildButton(colorScheme, context),
            ],
          ),
        ),
      ),
    );
  }

  _buildButton(ColorScheme colorScheme, BuildContext context) {
    return Container(
      color: colorScheme.onBackground,
      child: Row(children: [
        Expanded(
            child: GestureDetector(
          onTap: onCancel,
          child: Container(
            child: Text(
              textCancel ?? AppLocalizations.of(context).translate("cancel"),
              textAlign: TextAlign.center,
            ),
          ),
        )),
        Expanded(
            child: GestureDetector(
          onTap: onOk,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),
            child: const Center(
              child: Text(
                "Ok",
                style: TextStyle(
                  color: textDefault,
                ),
              ),
            ),
          ),
        )),
      ]),
    );
  }
}
