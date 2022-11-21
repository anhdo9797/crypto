import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/constants/assets.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:intl/intl.dart';

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
    final formatter = NumberFormat(',####');
    final value = formatter.format(1234567892124892).replaceAll(',', ' - ');

    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: Column(
        children: [
          // AnimatedRotation(
          //   turns: 0.2,
          //   duration: const Duration(seconds: 1),
          //   child: creditCard(context, value),
          // ),
          TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: vm.isFront ? 180 : 0, end: !vm.isFront ? 180 : 0),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double deg, Widget? child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-deg / 180 * pi),
                  child: creditCard(context, value),
                );
              }),

          ButtonWidget(onPressed: vm.onToggleCard, label: "add cvc")
        ],
      ),
    );
  }

  Container creditCard(BuildContext context, String value) {
    return Container(
      width: context.sizeConfig.screenWidth - (16 * 2),
      height: (context.sizeConfig.screenWidth - (16 * 2)) / 1.5,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
          image: AssetImage(Assets.cardBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "BANK NAME",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const ImageWidget(Assets.chip, width: 40, height: 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: "CreditCard",
                    fontSize: 16,
                  ),
                ),
                Text(
                  "4000",
                  style: TextStyle(
                    fontFamily: "CreditCard",
                    fontSize: 6,
                    color: context.colors.onSurface,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "VALIDATE\nTHUR",
                      style:
                          context.textTheme.displaySmall!.copyWith(fontSize: 7),
                    ),
                    const Space(),
                    Text(
                      "12/20",
                      style: context.textTheme.labelMedium!
                          .copyWith(fontFamily: "CreditCard", fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "DO CONG PHUOC ANH",
                  style: TextStyle(
                    fontFamily: "CreditCard",
                    fontSize: 18,
                  ),
                ),
                ImageWidget(
                  Assets.visa,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ]),
    );
  }
}
