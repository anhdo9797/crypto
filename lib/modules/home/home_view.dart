import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/dashboard_view.dart';
import 'package:flutter_boiler/modules/home/tabs/setting/setting.dart';
import 'package:flutter_boiler/modules/home/tabs/wallet/wallet.dart';
import 'package:flutter_boiler/share/constants/assets.dart';

import 'package:flutter_boiler/share/widgets/widgets.dart';
import '../../share/utils/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  int tabIndex = 0;

  List<Map> bottomTabs = [
    {
      "name": "dashboard",
      "icon": Assets.dashboard,
    },
    {
      "name": "wallet",
      "icon": Assets.wallet,
    },
    {
      "name": "Setting",
      "icon": Assets.setting,
    },
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final colorScheme = Theme.of(context).colorScheme;

    List<Widget> tabs = const [
      DashboardView(),
      WalletView(),
      SettingView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: tabs,
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 1,
        style: TabStyle.react,
        backgroundColor: context.colors.surface,
        onTap: (value) => setState(() => tabIndex = value),
        items: bottomTabs
            .map(
              (button) => TabItem(
                  icon: ImageWidget(
                button['icon'],
                color: context.textTheme.bodyLarge!.color,
              )),
            )
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
