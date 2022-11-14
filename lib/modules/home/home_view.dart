import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/dashboard_view.dart';
import 'package:flutter_boiler/modules/home/tabs/setting/setting.dart';
import 'package:flutter_boiler/share/constants/assets.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';

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
      SettingView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: tabs,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: colorScheme.primaryContainer,
        backgroundColor: Colors.transparent,
        color: colorScheme.surface,
        height: kBottomNavigationBarHeight,
        onTap: (value) => setState(() => tabIndex = value),
        animationDuration: const Duration(milliseconds: 400),
        items: bottomTabs
            .map(
              (button) => ImageWidget(
                button['icon'],
                color: Colors.white,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
