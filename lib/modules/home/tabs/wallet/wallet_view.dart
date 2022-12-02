import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';

import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: context.sizeConfig.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: context.colors.primary,
              ),
              width: context.sizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My balance:",
                      style: context.titleMedium!.copyWith(
                        color: Colors.white,
                      )),
                  _buildTotalBallance(context, vm),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("My Cards: "),
                ButtonWidget(
                  icon: const Icon(Icons.add),
                  type: ButtonType.icon,
                  onPressed: vm.addCard,
                  label: '',
                  padding: 8,
                )
              ],
            ),
            CarouselSlider(
              items: vm.creditCards
                  .map((e) => CreditCard(
                      id: e.id,
                      date: e.date!,
                      nameHolder: e.nameHolder!,
                      bankName: e.bankName!,
                      cvv: e.cvv!))
                  .toList(),
              options: CarouselOptions(
                height: 220,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBallance(BuildContext context, WalletViewModel vm) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 800),
      firstChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            formatCurrency(122123333),
            style: context.titleLarge!.copyWith(color: Colors.white),
          ),
          IconButton(
            onPressed: vm.onToggleBalance,
            icon: const Icon(Icons.visibility_off, color: Colors.white),
          )
        ],
      ),
      secondChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "＄ ***",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          IconButton(
            onPressed: vm.onToggleBalance,
            icon: const Icon(Icons.visibility),
          )
        ],
      ),
      crossFadeState: vm.isShowBalance
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}
