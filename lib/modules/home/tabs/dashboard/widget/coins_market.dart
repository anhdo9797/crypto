import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/coin_market_model.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/widget/img_line_chart.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/colors.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';

class CoinsMarket extends StatelessWidget {
  const CoinsMarket({Key? key, required this.coins}) : super(key: key);
  final List<CoinMarket> coins;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const Space(height: 4),
        itemCount: coins.length,
        shrinkWrap: true,
        cacheExtent: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) => _buildItem(context, coins[index])));
  }

  _buildItem(BuildContext context, CoinMarket coin) {
    final color =
        (coin.priceChangePercentage24h ?? 0) > 0 ? successColor : errorColor;

    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () => AppRouter.routes.go(
        '/home/coins/${coin.id}?img=${coin.image}',
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Hero(
                      tag: coin.symbol ?? "symbol",
                      child: ImageWidget(
                        coin.image ?? "",
                        width: 20,
                        height: 20,
                        semanticsLabel: coin.symbol ?? "symbol",
                      ),
                    ),
                    const Space(),
                    Text(coin.name ?? ""),
                  ],
                ),
                Text(
                  formatCurrency(coin.currentPrice),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
              const Space(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    ChartImg(coin: coin, width: 50),
                    Text(
                      fixedPercentage(coin.priceChangePercentage24h),
                      style: TextStyle(color: color),
                    ),
                  ],
                ),
                const Space(),
                Flexible(
                  child: Text(
                    fixedNumber(coin.priceChange24h, fractionDigits: 8),
                    style: TextStyle(color: context.colors.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
