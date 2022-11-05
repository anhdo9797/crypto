import 'dart:async';

import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';

class CoinDetailViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();

  final String id;
  CoinDetailViewModel(this.id);

  @override
  FutureOr<void> init() {}

  void getMarketChart() async {}
}
