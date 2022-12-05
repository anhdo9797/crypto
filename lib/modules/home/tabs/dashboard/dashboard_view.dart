import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_crypto/data/models/coin_market_model.dart';
import 'package:s_crypto/data/models/market_filter_model.dart';
import 'package:s_crypto/data/models/user.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/modules/home/tabs/dashboard/dashboard_view_model.dart';
import 'package:s_crypto/modules/home/tabs/dashboard/widget/coin_trendy.dart';
import 'package:s_crypto/modules/home/tabs/dashboard/widget/coins_market.dart';
import 'package:s_crypto/modules/home/tabs/dashboard/widget/coins_recommended.dart';
import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/services/user_manager.dart';

import 'package:s_crypto/share/utils/utils.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import 'package:skeletons/skeletons.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(vmBuilder: (_) => DashboardViewModel(), builder: _builder);
  }

  Widget _builder(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimension.padding),
        child: viewModel.isInitialized
            ? SkeletonListView()
            : _buildBody(context, viewModel),
      ),
    );
  }

  _buildBody(BuildContext context, DashboardViewModel viewModel) {
    final coin = viewModel.coins.isEmpty ? CoinMarket() : viewModel.coins[0];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.sizeConfig.top + 16),
          _buildAppBar(context),
          _buildWallet(context, viewModel),
          const Space(),
          CoinTrendy(coin: coin),
          const Space(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text("Recommended"),
          ),
          SizedBox(
            height: SizeConfig().screenHeight * 0.13,
            child: CoinsRecommended(
              coins: viewModel.coinsTrending,
            ),
          ),
          const Space(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("For you"),
                DropDownWidget<MarketFilterModel>(
                  onChanged: viewModel.onFilter,
                  value: viewModel.filterMarket.firstWhere(
                      (element) => element.key == viewModel.filterValue),
                  items: viewModel.filterMarket
                      .map<DropdownMenuItem<MarketFilterModel>>(
                          (MarketFilterModel value) {
                    return DropdownMenuItem<MarketFilterModel>(
                      value: value,
                      child: Text(value.value ?? ""),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          CoinsMarket(coins: viewModel.coins)
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.person),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildWallet(BuildContext context, DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.padding),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My wallet",
              style: context.labelLarge!.copyWith(color: textDefault),
            ),
            DropDownWidget(
              onChanged: (String? value) {
                // This is called when the user selects an item.
              },
              value: viewModel.dropDown[0],
              items: viewModel.dropDown
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: StreamBuilder<UserModel>(
            stream: UserManager.user.stream,
            builder: ((context, snapshot) => Text(
                  formatCurrency(snapshot.data?.balance),
                  style: context.titleLarge!.copyWith(color: textDefault),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(
              color: context.colors.onSurface.withOpacity(0.3),
              label: "Transfer",
              icon: Icons.transform_rounded,
            ),
            _buildButton(
              color: context.colors.onSurface.withOpacity(0.3),
              label: "Deposit",
              icon: Icons.currency_exchange_rounded,
            ),
            _buildButton(
              label: "Swap",
              icon: Icons.swap_calls_outlined,
              color: context.colors.onSurface.withOpacity(0.3),
            ),
          ],
        )
      ]),
    );
  }

  _buildButton({IconData? icon, String label = "", color}) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(AppDimension.padding / 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: textDefault,
                ),
                const Space(width: 8),
                Text(
                  label,
                  style: const TextStyle(color: textDefault),
                ),
              ],
            ),
          ),
        ),
      );
}
