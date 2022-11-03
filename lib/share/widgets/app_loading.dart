import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/colors.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xff292929).withOpacity(0.6)),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14,
              child: child,
            );
          },
          child: const AppLogo(size: 80),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
