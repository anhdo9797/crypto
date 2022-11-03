import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/constants.dart';

class LinearContainer extends StatelessWidget {
  const LinearContainer({
    Key? key,
    required this.child,
    this.type = LinearType.container,
    this.colors,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final LinearType type;
  final List<Color>? colors;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 1.0,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ?? getColors(context),
        ),
        borderRadius: borderRadius ??
            (type == LinearType.primary
                ? BorderRadius.circular(AppDimension.borderRadius)
                : null),
      ),
      child: child,
    );
  }

  List<Color> getColors(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (type) {
      case LinearType.primary:
        return [
          colorScheme.primary,
          colorScheme.primaryContainer,
        ];
      default:
        return [
          colorScheme.background,
          colorScheme.onBackground.withOpacity(0.7),
        ];
    }
  }
}
