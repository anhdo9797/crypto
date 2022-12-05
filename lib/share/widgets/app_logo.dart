import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/assets.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({Key? key, this.size = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageWidget(
      Assets.logo,
      fit: BoxFit.cover,
      width: size,
      height: size,
      color: context.colors.primary,
    );
  }
}
