import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/coin_detail/coin_detail_view_model.dart';
import 'package:candlesticks/candlesticks.dart'; 
import 'package:flutter_boiler/share/utils/format.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class CoinDetailView extends StatelessWidget {
  const CoinDetailView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BaseView<CoinDetailViewModel>(
        vmBuilder: (context) => CoinDetailViewModel(id), builder: _buildBody);
  }

  Widget _buildBody(BuildContext context, CoinDetailViewModel vm) {
    final size = SizeConfig();
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: vm.scrollViewController,
            slivers: [
              _buildAppBar(colorScheme, vm),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Candlesticks(
                        candles: vm.candles,
                        style: CandleSticksStyle.dark(
                          background: colorScheme.background,
                          toolBarColor: colorScheme.background,
                        ),
                        actions: vm.filter
                            .map((e) => ToolBarAction(
                                  width: size.screenWidth * 0.15,
                                  child: Text(
                                    e,
                                    style:
                                        TextStyle(color: colorScheme.onSurface),
                                  ),
                                  onPressed: () {},
                                ))
                            .toList(),
                      ),
                    ),
                    _buildDescription(vm, colorScheme)
                  ],
                ),
              ),
            ],
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              bottom: vm.position < 66 ? 20 : -150.0,
              right: 16,
              left: 16,
              child: Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      label: "Selling",
                      onPressed: () {},
                      backgroundColor: colorScheme.error,
                    ),
                  ),
                  const Space(),
                  Expanded(
                    child: ButtonWidget(
                      label: "Buy",
                      onPressed: () {},
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(ColorScheme colorScheme, CoinDetailViewModel vm) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 120,
      backgroundColor: colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: vm.position < 66
            ? Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  vm.coin.name ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Space(),
                  Text(
                    formatCurrency(vm.coin.marketData?.currentPrice?.usd),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ImageWidget(
                      vm.coin.image?.large ?? "",
                      width: 24,
                      height: 24,
                      semanticsLabel: vm.coin.symbol ?? "",
                    ),
                  ),
                ],
              ),
        background: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: colorScheme.background,
                  height: 56,
                  padding: const EdgeInsets.only(left: 16),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency(vm.coin.marketData?.currentPrice?.usd),
                          style: const TextStyle(
                            // color: colorScheme.onSurface,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Space(),
                        Text(
                          "≈ ${fixedPercentage(vm.coin.marketData?.marketCapChangePercentage24h)}",
                          style: TextStyle(
                            color: getColorPercentage(vm
                                .coin.marketData?.marketCapChangePercentage24h),
                            fontSize: 16,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: colorScheme.background,
                    radius: (60 / 2) + 16,
                    child: Hero(
                      tag: vm.coin.symbol ?? "symbol",
                      child: ImageWidget(
                        vm.coin.image?.large ?? "",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
      // backgroundColor: Colors.red,
    );
  }

  _buildDescription(vm, colorScheme) {
    if (vm.coin.description?.en != '' && vm.coin.description?.en != null) {
      return Column(
        children: [
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Html(data: vm.coin.description?.en),
          )
        ],
      );
    }

    return const SizedBox();
  }
}
