import 'package:flutter/material.dart';
import 'package:s_crypto/modules/home/tabs/wallet/wallet.dart';
import 'package:s_crypto/share/constants/constants.dart';

import 'package:s_crypto/share/utils/utils.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class WalletHeaderWidget extends StatelessWidget {
  const WalletHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<WalletViewModel>(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: EdgeInsets.only(
            top: context.sizeConfig.top + 16,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: primary,
          ),
          width: context.sizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My balance:",
                  style: context.labelLarge!.copyWith(
                    color: textDefault,
                  )),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 800),
                firstChild: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formatCurrency(122123333),
                      style: context.titleLarge!.copyWith(color: textDefault),
                    ),
                    IconButton(
                      onPressed: vm.onToggleBalance,
                      icon:
                          const Icon(Icons.visibility_off, color: textDefault),
                    )
                  ],
                ),
                secondChild: Row(
                  children: [
                    Text(
                      "＄ ***",
                      style: context.titleLarge!.copyWith(color: textDefault),
                    ),
                    IconButton(
                      onPressed: vm.onToggleBalance,
                      icon: const Icon(Icons.visibility, color: textDefault),
                    )
                  ],
                ),
                crossFadeState: vm.isShowBalance
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
              const Space(),
              Row(
                children: [
                  _buildVolatility(context, vm),
                  const Space(),
                  _buildVolatility(context, vm, isIncome: false),
                ],
              ),
              const Space(),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 16,
          left: 16,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: context.colors.onBackground,
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Center(
                        child: Text(
                      "Withdraw",
                      style: context.bodySmall!.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Center(
                          child: Text(
                        "Recharge",
                        style: context.bodySmall!.copyWith(
                          color: textDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildVolatility(
    BuildContext context,
    WalletViewModel vm, {
    isIncome = true,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: isIncome ? successColor : errorColor,
                child: Text(
                  isIncome ? "➚" : "➘",
                  style: const TextStyle(
                    fontSize: 14,
                    color: textDefault,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Space(width: 4),
              Text(
                isIncome ? "Income" : "Expensive",
                style: const TextStyle(color: textDefault),
              ),
            ],
          ),
          const Space(height: 8),
          Text(
            "12.332,0",
            style: context.titleSmall!.copyWith(
              color: isIncome ? successColor : errorColor,
              fontWeight: FontWeight.bold,
            ),
          )
          // Text("Expensive"),
        ],
      ),
    );
  }
}
