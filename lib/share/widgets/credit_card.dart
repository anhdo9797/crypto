import 'dart:math';

import 'package:flutter/material.dart';
import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import '../constants/assets.dart';
import '../utils/utils.dart';

final creditCardBgs = [
  Assets.cardBg,
  Assets.cardBg2,
  Assets.cardBg3,
];

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key? key,
    required this.id,
    required this.date,
    required this.nameHolder,
    required this.bankName,
    required this.cvv,
    this.isFront = true,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final String id;
  final String date;
  final String nameHolder;
  final String bankName;
  final String cvv;
  final Duration duration;

  final bool isFront;

  @override
  Widget build(BuildContext context) {
    String bg = creditCardBgs[Random().nextInt(3)];

    return TweenAnimationBuilder(
        tween: Tween<double>(begin: isFront ? 180 : 0, end: !isFront ? 180 : 0),
        duration: duration,
        builder: (BuildContext context, double deg, Widget? child) {
          return Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(-deg / 180 * pi),
            child: _buildBody(context, deg, bg),
          );
        });
  }

  Widget _buildBody(BuildContext context, double deg, String bg) {
    return Container(
      width: context.sizeConfig.screenWidth,
      height: (context.sizeConfig.screenWidth) / 1.6,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
          image: AssetImage(bg),
          fit: BoxFit.cover,
        ),
      ),
      child: isFront
          ? frontWidget(context)
          : TweenAnimationBuilder(
              tween:
                  Tween<double>(begin: !isFront ? 0 : 1, end: isFront ? 0 : 1),
              duration: duration,
              builder: ((context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: backWidget(),
                );
              })),
    );
  }

  Widget frontWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                bankName.toUpperCase(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textDefault,
                ),
              ),
            ],
          ),
          const ImageWidget(Assets.chip, width: 40, height: 36),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id,
                style: const TextStyle(
                  fontFamily: "CreditCard",
                  fontSize: 16,
                  color: textDefault,
                ),
              ),
              const Text(
                "4000",
                style: TextStyle(
                  fontFamily: "CreditCard",
                  fontSize: 6,
                  color: textDefault,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "VALIDATE\nTHUR",
                    style: context.textTheme.displaySmall!.copyWith(
                      fontSize: 7,
                      color: textDefault,
                    ),
                  ),
                  const Space(),
                  Text(
                    date,
                    style: context.textTheme.labelMedium!.copyWith(
                      fontFamily: "CreditCard",
                      fontSize: 12,
                      color: textDefault,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nameHolder,
                style: const TextStyle(
                  fontFamily: "CreditCard",
                  fontSize: 18,
                  color: textDefault,
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 80,
                ),
                child: CardUtils.getCardIcon(id) ?? const SizedBox(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget backWidget() {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: !isFront ? 0 : 1, end: !isFront ? 1 : 0),
        duration: duration,
        builder: ((context, double value, child) {
          return Opacity(
            opacity: value,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                ),
                Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-180 / 180 * pi),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.grey[400],
                          height: 40,
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Text(
                            cvv,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Space(width: 40),
                    ],
                  ),
                ),
                const Spacer(flex: 1)
              ],
            ),
          );
        }));
  }
}
