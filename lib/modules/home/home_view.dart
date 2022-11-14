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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (value) => setState(() => tabIndex = value),
        showSelectedLabels: false,
        items: bottomTabs
            .map<BottomNavigationBarItem>(
              (button) => BottomNavigationBarItem(
                label: button['name'],
                icon: Column(
                  children: [
                    if (tabIndex == bottomTabs.indexOf(button)) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Space(height: 8),
                    ],
                    ImageWidget(
                      button['icon'],
                      color: tabIndex == bottomTabs.indexOf(button)
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _buildIcon() {}

  @override
  bool get wantKeepAlive => true;
}
