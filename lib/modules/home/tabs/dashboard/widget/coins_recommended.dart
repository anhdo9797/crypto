import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/coin_market_model.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoinsRecommended extends StatelessWidget {
  const CoinsRecommended({Key? key, required this.coins}) : super(key: key);
  final List<CoinMarket> coins;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: coins.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => _buildItem(context, coins[index])));
  }

  _buildItem(BuildContext context, CoinMarket coin) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: SizeConfig().screenWidth * 0.5,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageWidget(
                  coin.image ?? "",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 40,
                  height: 20,
                  child: WebView(
                    gestureNavigationEnabled: true,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: getChartUrl(coin.image),
                    backgroundColor: colorScheme.surface,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    fixedNumber(coin.priceChange24h, fractionDigits: 3),
                    style: TextStyle(
                      color: getColorPercentage(coin.priceChange24h),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${coin.currentPrice}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ],
            ),
          ]),
    );
  }
}
