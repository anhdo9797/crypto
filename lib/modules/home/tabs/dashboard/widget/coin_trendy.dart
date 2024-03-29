import 'package:flutter/material.dart';
import 'package:s_crypto/data/models/coin_market_model.dart';
import 'package:s_crypto/modules/home/tabs/dashboard/widget/img_line_chart.dart';

import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/utils/utils.dart';
import 'package:s_crypto/share/widgets/widgets.dart';

class CoinTrendy extends StatelessWidget {
  const CoinTrendy({Key? key, required this.coin}) : super(key: key);
  final CoinMarket coin;

  @override
  Widget build(BuildContext context) {
    final color =
        (coin.priceChangePercentage24h ?? 0) > 0 ? successColor : errorColor;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.onTertiary,
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
              child: ChartImg(coin: coin),
            ),
            Text(
              fixedPercentage(coin.marketCapChangePercentage24h),
              style: TextStyle(color: color),
            ),
          ],
        )
      ]),
    );
  }
}
