import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';

import './wallet.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletViewModel>(
      vmBuilder: (_) => WalletViewModel(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, WalletViewModel vm) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}
