import 'dart:async';
import 'dart:convert';
import 'dart:developer' as develop;
import 'dart:math';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_boiler/data/models/models.dart';
import 'package:flutter_boiler/data/repositories/coin_repository.dart';
import 'package:flutter_boiler/di/service_locator.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinDetailViewModel extends BaseViewModel {
  final CoinRepository coinRepository = getIt.get<CoinRepository>();
  // final AblyService ablyService = getIt.get<AblyService>();

  final String id;
  CoinDetailViewModel(this.id);

  MarketChartResponse chartData = MarketChartResponse();
  List<Candle> candles = [];
  late StreamSubscription<ably.Message> listen;
  WebSocketChannel? channel;

  @override
  FutureOr<void> init() async {
    getMarketChart();
    connectSocket();
    // listen = _coinChange();
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
    // await listen.cancel();
    if (channel != null) {
      channel!.sink.close();
    }
    super.dispose();
  }

  StreamSubscription<ably.Message> _coinChange() {
    final clientOptions =
        ably.ClientOptions(key: dotenv.get("ABLY_KEY_ROOT_KEY"));

    ably.Realtime realtime = ably.Realtime(options: clientOptions);
    realtime.connect();

    final channelName = "[product:ably-coindesk/bitcoin]$id:usd";
    final channel = realtime.channels.get(channelName);
    final Stream<ably.Message> messageStream = channel.subscribe();
    return messageStream.where((event) => event.data != null).listen((message) {
      final price = double.parse("${message.data}");

      final currentCandle = Candle(
        date: DateTime.now(),
        high: price + Random().nextInt(3),
        low: price - Random().nextInt(3),
        open: price - Random().nextDouble() * 2,
        close: price + Random().nextDouble() * 2,
        volume: price,
      );
      candles = [
        currentCandle,
        ...candles,
      ];

      notifyListeners();
    });
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
}
