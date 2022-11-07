import 'dart:developer';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AblyService {
  AblyService._(this._realtime);
  get realtime => _realtime;

  final ably.Realtime _realtime;
  List<dynamic> _coinUpdates = [];

  static Future<AblyService> init() async {
    final ably.ClientOptions _clientOptions =
        ably.ClientOptions(key: dotenv.get("ABLY_KEY_SUB_KEY"));

    final _realtime = ably.Realtime(options: _clientOptions);
    await _realtime
        .connect()
        .then((value) => log("realtime connect success: "))
        .catchError((onError) => log("realtime: $onError"));

    return AblyService._(_realtime);
  }

  listenChangeCoin(String code) {
    ably.RealtimeChannel channel =
        _realtime.channels.get('[product:ably-coindesk/bitcoin]$code:usd');

    final Stream<ably.Message> messageStream = channel.subscribe();
    messageStream.forEach((element) {
      log("message: $element");
    });
    return messageStream.where((event) => event.data != null).listen((message) {
      log("Changed $code: ${message.data}");
    });
  }

  close() {}
}
