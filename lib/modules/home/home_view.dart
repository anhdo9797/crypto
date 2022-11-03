import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/home/tabs/dashboard/dashboard_view.dart';
import 'package:flutter_boiler/modules/home/tabs/friends/friends_view.dart';
import 'package:flutter_boiler/modules/home/tabs/setting/setting.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
