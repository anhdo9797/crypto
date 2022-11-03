import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/home/tabs/friends/friend_view_model.dart';
import 'package:flutter_boiler/share/constants/dimension.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';

import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:skeletons/skeletons.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(vmBuilder: (_) => FriendsViewModel(), builder: _builder);
  }

  Widget _builder(BuildContext context, FriendsViewModel viewModel) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My friends'),
        // status bar brightness
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
