import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/coin_market_model.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartImg extends StatelessWidget {
  const ChartImg({
    Key? key,
    this.width = 40,
    this.height = 20,
    required this.coin,
  }) : super(key: key);

  final double width;
  final double height;
  final CoinMarket coin;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    return SizedBox(
      width: width,
      height: height,
      child: WebView(
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: getChartUrl(coin.image),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
