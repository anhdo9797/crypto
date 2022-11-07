import 'dart:async';
import 'dart:developer' as develop;
import 'dart:math';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/services/ably_service.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CoinDetailViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();
  final AblyService ablyService = getIt.get<AblyService>();

  final String id;
  CoinDetailViewModel(this.id);

  MarketChartResponse chartData = MarketChartResponse();
  List<Candle> candles = [];
  late StreamSubscription<ably.Message> listen;
  @override
  FutureOr<void> init() async {
    getMarketChart();
    listen = _coinChange();
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

  @override
  void dispose() async {
    develop.log("remove listening");
    // TODO: implement dispose
    await listen.cancel().then((value) => develop.log("remove listening"));
    super.dispose();
  }

  StreamSubscription<ably.Message> _coinChange() {
    final clientOptions =
        ably.ClientOptions(key: dotenv.get("ABLY_KEY_ROOT_KEY"));

    // Use ClientOptions to create Realtime or REST instance
    ably.Realtime realtime = ably.Realtime(options: clientOptions);
    realtime.connect();
    ably.Rest rest = ably.Rest(options: clientOptions);

    final channelName = "[product:ably-coindesk/bitcoin]$id:usd";
    final channel = realtime.channels.get(channelName);
    final Stream<ably.Message> messageStream = channel.subscribe();
    return messageStream.where((event) => event.data != null).listen((message) {
      final price = double.parse("${message.data}");
      final random = Random().nextInt(10);
      final low = price - random;

      develop.log("price: $price");
      candles.add(Candle(
          date: DateTime.now(),
          high: price + Random().nextInt(900),
          low: price - Random().nextInt(100),
          open: price - Random().nextDouble() * 190,
          close: price - Random().nextDouble() * 120,
          volume: price));

      notifyListeners();
    });
  }
}
