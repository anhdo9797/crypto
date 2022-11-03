import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/models/coin_market_model.dart';
import 'package:flutter_boiler/data/models/user.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/dashboard_view_model.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/widget/coin_trendy.dart';
import 'package:flutter_boiler/share/constants/constants.dart';
import 'package:flutter_boiler/share/services/user_manager.dart';

import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:skeletons/skeletons.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(vmBuilder: (_) => DashboardViewModel(), builder: _builder);
  }

  Widget _builder(BuildContext context, DashboardViewModel viewModel) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Icon(Icons.person),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.notifications),
            ),
          ),
          const Space()
        ],
      ),
      body: ContainerWidget(
        padding: 0,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(AppDimension.padding),
            width: SizeConfig().screenWidth,
            height: SizeConfig().screenHeight,
            child: viewModel.isInitialized
                ? SkeletonListView()
                : _buildBody(context, viewModel),
          ),
        ),
      ),
    );
  }

  _buildBody(BuildContext context, DashboardViewModel viewModel) {
    final coin = viewModel.coins.isEmpty ? CoinMarket() : viewModel.coins[0];
    // const symbol = "﹩" | "€";

    return Column(
      children: [
        _buildWallet(context, viewModel),
        const Space(),
        if (viewModel.coins.isNotEmpty) CoinTrendy(coin: coin)
      ],
    );
  }

  _buildWallet(BuildContext context, DashboardViewModel viewModel) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    //TODO: mock
    const balance = "10,000.89";
    return Container(
      padding: const EdgeInsets.all(AppDimension.padding),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My wallet"),
            Container(
              padding: const EdgeInsets.all(AppDimension.padding / 4),
              decoration: BoxDecoration(
                color: colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: viewModel.dropDown[0],
                isDense: true,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                },
                items: viewModel.dropDown
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: StreamBuilder<UserModel>(
            stream: UserManager.user.stream,
            builder: ((context, snapshot) => Text(
                  "﹩ ${snapshot.data?.balance ?? 0}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(
              color: Colors.black,
              label: "Transfer",
              icon: Icons.transform_rounded,
            ),
            _buildButton(
              color: colorScheme.inverseSurface,
              label: "Deposit",
              icon: Icons.currency_exchange_rounded,
            ),
            _buildButton(
              label: "Swap",
              icon: Icons.swap_calls_outlined,
              color: colorScheme.inverseSurface,
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
                Icon(icon),
                Text(label),
              ],
            ),
          ),
        ),
      );
}
