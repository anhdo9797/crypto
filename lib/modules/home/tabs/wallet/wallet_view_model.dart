import 'dart:async';

import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/routes/routes.dart';

class WalletViewModel extends BaseViewModel {
  bool isFront = true;
  @override
  FutureOr<void> init() {}

  void onToggleCard() {
    // isFront = !isFront;
    // notifyListeners();
    AppRouter.routes.goNamed(APP_PAGE.addWallet.toName);
  }
}
