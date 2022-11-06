import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';

class CoinDetailViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();

  final String id;
  CoinDetailViewModel(this.id);

  MarketChartResponse chartData = MarketChartResponse();
  List<Candle> candles = [];

  @override
  FutureOr<void> init() async {
    getMarketChart();
  }

  void getMarketChart() async {
    try {
      final data = await coinRepository.getOhlc(id);

      candles = [...data, ...data, ...data]
          .reversed
          .map((e) => Candle(
              date: DateTime.fromMillisecondsSinceEpoch(e[0]),
              high: e[2],
              low: e[3],
              open: e[1],
              close: e[4],
              volume: e[2]))
          .toList();
      notifyListeners();
    } catch (e) {}
  }
}
