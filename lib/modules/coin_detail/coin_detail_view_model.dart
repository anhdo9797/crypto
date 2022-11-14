import 'dart:async';
import 'dart:convert';
import 'dart:developer' as develop;

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/constants/constants.dart';
import 'package:live_activities/live_activities.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinDetailViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();
  // final AblyService ablyService = getIt.get<AblyService>();
  final _liveActivitiesPlugin = LiveActivities();
  String? _latestActivityId;

  final String id;
  CoinDetailViewModel(this.id);

  WebSocketChannel? channel;

  /// state
  MarketChartResponse chartData = MarketChartResponse();
  List<Candle> candles = [];
  CoinDetail coin = CoinDetail();
  double position = 0;

  late Timer timerRequest;
  late ScrollController scrollViewController;

  List<String> filter = ["1d", "7d", "14d", "1m"];

  @override
  FutureOr<void> init() async {
    scrollViewController = ScrollController();

    getMarketChart();

    await getCoin();
    _startActivities();

    timerRequest = Timer.periodic(const Duration(seconds: 30), (timer) {
      getMarketChart();
      getCoin();
      _updateActivity();
    });

    scrollViewController.addListener(_scrollListener);
  }

  void getMarketChart() async {
    try {
      final data = await coinRepository.getOhlc(id);
      candles = [...data]
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

  getCoin() async {
    try {
      coin = await coinRepository.getCoinDetail(id);
      notifyListeners();

      develop.log('CurrentPrice: ${coin.marketData?.currentPrice?.usd ?? 0}');
    } catch (e) {
      develop.log("Get coin error: $e");
    }
  }

  @override
  void dispose() async {
    develop.log("remove listening");

    timerRequest.cancel();
    scrollViewController.dispose();
    if (AppValue.isIos) {
      _liveActivitiesPlugin.endActivity(_latestActivityId ?? "");
    }

    super.dispose();
  }

  connectSocket() async {
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://stream.binance.com:9443/ws'));

    channel!.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["BNBBTC" + "@kline_" + '1m'],
          "id": 1
        },
      ),
    );

    channel!.stream.listen((event) {
      develop.log("channel.stream.listen: $event");
    });
  }

  _scrollListener() {
    if (scrollViewController.offset >=
            scrollViewController.position.maxScrollExtent &&
        !scrollViewController.position.outOfRange) {}

    position = scrollViewController.offset;
    notifyListeners();
  }

  /// live activities handler
  _startActivities() async {
    if (AppValue.isIos) {
      _latestActivityId = await _liveActivitiesPlugin.createActivity({
        "name": coin.name ?? "",
        "symbol": coin.symbol ?? "",
        "price": "${coin.marketData?.currentPrice?.usd ?? 0}"
      });
    }
  }

  _updateActivity() async {
    if (AppValue.isIos) {
      _liveActivitiesPlugin.updateActivity(_latestActivityId ?? "", {
        "name": coin.name ?? "",
        "symbol": coin.symbol ?? "",
        "price": "${DateTime.now().millisecondsSinceEpoch}"
      });
    }
  }
}
