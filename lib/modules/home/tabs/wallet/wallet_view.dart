import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/home/tabs/wallet/widget/wallet_header_widget.dart';
import 'package:flutter_boiler/share/constants/constants.dart';

import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
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
            const WalletHeaderWidget(),
            const Space(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Cards: ",
                    style: context.labelMedium,
                  ),
                  ButtonWidget(
                    icon: const Icon(Icons.add, color: textDefault),
                    type: ButtonType.icon,
                    onPressed: vm.addCard,
                    label: '',
                    padding: 8,
                  )
                ],
              ),
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
            const Space(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Cards: ",
                    style: context.labelMedium,
                  ),
                  ButtonWidget(
                    icon: const Icon(
                      Icons.settings_brightness_outlined,
                      color: textDefault,
                    ),
                    type: ButtonType.icon,
                    onPressed: vm.addCard,
                    label: '',
                    padding: 8,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
