import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/providers/provider.dart';
import 'package:flutter_boiler/share/utils/app_localizations.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingViewModel extends BaseViewModel {
  SettingViewModel(this.context);
  final BuildContext context;

  late AuthProvider authProvider;

  @override
  FutureOr<void> init() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  void logout() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => DialogWidget(
        title: AppLocalizations.of(context).translate('confirm_logout'),
        message:
            AppLocalizations.of(context).translate('confirm_logout_message'),
        onCancel: () => Navigator.pop(context),
        onOk: () {
          Navigator.pop(context);
          authProvider.logOut();
        },
      ),
    );
  }
}
