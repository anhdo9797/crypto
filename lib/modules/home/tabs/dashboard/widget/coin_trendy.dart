import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/coin_market_model.dart';
import 'package:flutter_boiler/share/constants/colors.dart';
import 'package:flutter_boiler/share/constants/dimension.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoinTrendy extends StatelessWidget {
  const CoinTrendy({Key? key, required this.coin}) : super(key: key);
  final CoinMarket coin;

  @override
  Widget build(BuildContext context) {
    final color = (coin.priceChangePercentage24h ?? 0) > 0
        ? AppColors.success
        : AppColors.error;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.onBackground,
          borderRadius: BorderRadius.circular(AppDimension.padding)),
      padding: const EdgeInsets.all(AppDimension.padding),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            ImageWidget(
              coin.image ?? "",
              width: 32,
              height: 32,
            ),
            const Space(),
            Text(coin.name ?? ""),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${coin.currentPrice ?? 0}',
              style: TextStyle(color: color),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 40,
                height: 20,
                child: WebView(
                  gestureNavigationEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: 'https://www.coingecko.com/coins/1/sparkline',
                  backgroundColor: colorScheme.onBackground,
                ),
              ),
            ),
            Text(
              formatPercentage(coin.marketCapChangePercentage24h),
              style: TextStyle(color: color),
            ),
          ],
        )
      ]),
    );
  }
}
