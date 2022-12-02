import 'dart:async';

import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/routes/routes.dart';

class WalletViewModel extends BaseViewModel {
  List<CreditCardModel> creditCards = [
    CreditCardModel(
      id: "4567672898836748",
      bankName: "VJS",
      date: "12/02",
      nameHolder: "DO CONG DEV ANH",
      cvv: "789",
    ),
    CreditCardModel(
      id: "4264672298332748",
      bankName: "VCB",
      date: "11/02",
      nameHolder: "NGUYEN VAN DINH",
      cvv: "339",
    ),
    CreditCardModel(
      id: "4264673228332748",
      bankName: "VCB",
      date: "11/02",
      nameHolder: "DANG VAN ROBERT",
      cvv: "339",
    ),
  ];

  bool isShowBalance = false;

  @override
  FutureOr<void> init() {}

  void addCard() => AppRouter.routes.goNamed(APP_PAGE.addWallet.toName);
  void onToggleBalance() {
    isShowBalance = !isShowBalance;
    notifyListeners();
  }
}
