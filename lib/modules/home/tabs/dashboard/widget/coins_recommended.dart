import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/models.dart';

import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoinsRecommended extends StatelessWidget {
  const CoinsRecommended({Key? key, required this.coins, this.loading = false})
      : super(key: key);
  final List<CoinTrending> coins;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: coins.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => _buildItem(context, coins[index])));
  }

  _buildItem(BuildContext context, CoinTrending coin) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Container(
        width: SizeConfig().screenWidth * 0.5,
        decoration: BoxDecoration(
          // color: colorScheme.surface,
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
                  Row(
                    children: [
                      ImageWidget(
                        coin.large ?? "",
                        width: 24,
                        height: 24,
                      ),
                      const Space(width: 8),
                      Text(
                        "${coin.symbol}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                    height: 20,
                    child: WebView(
                      gestureNavigationEnabled: true,
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: getChartUrl(coin.thumb),
                      backgroundColor: colorScheme.surface,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "rank",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  Text(
                    "${coin.marketCapRank}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
