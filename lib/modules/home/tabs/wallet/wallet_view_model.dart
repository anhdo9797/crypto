import 'dart:async';

import 'package:flutter_boiler/modules/base/base.dart';

class WalletViewModel extends BaseViewModel {
  bool isFront = false;
  @override
  FutureOr<void> init() {}

  void onToggleCard() {
    isFront = !isFront;
    notifyListeners();
  }
}
