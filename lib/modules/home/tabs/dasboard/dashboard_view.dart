import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/home/tabs/dasboard/dashboard_view_model.dart';
import 'package:flutter_boiler/share/constants/dimension.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';
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
        title: Icon(Icons.person),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
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
                : ListView.separated(
                    separatorBuilder: (BuildContext, index) {
                      return const Divider(height: 2);
                    },
                    itemCount: viewModel.users.length,
                    itemBuilder: ((context, index) {
                      final user = viewModel.users[index];
                      return ListTile(
                        leading: ImageWidget(
                          user.avatar ?? "",
                          width: 52,
                          height: 52,
                          radius: 4,
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text('${user.email}'),
                      );
                    })),
          ),
        ),
      ),
    );
  }
}
