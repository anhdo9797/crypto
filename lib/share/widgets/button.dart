import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/constants/constants.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.type = ButtonType.primary,
    required this.onPressed,
    required this.label,
    this.child,
    this.icon,
    this.colors,
    this.labelStyle = const TextStyle(color: AppColors.lightText),
  }) : super(key: key);

  final ButtonType type;
  final Function() onPressed;
  final String? label;
  final Widget? child;
  final Widget? icon;
  final List<Color>? colors;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final _child = child ??
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const Space(width: 4)],
            Text(
              (label ?? '').toUpperCase(),
              style: labelStyle,
            )
          ],
        );

    switch (type) {
      case ButtonType.link:
        return TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text(
              label ?? "",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.blue,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
            ));
      case ButtonType.ghost:
        return TextButton(
            onPressed: onPressed, child: child ?? Text(label ?? ""));
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDimension.componentHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimension.borderRadius),
            ),
            side: const BorderSide(color: AppColors.primary, width: 1),
          ),
          child: _child,
        );
      default:
        return LinearContainer(
          type: LinearType.primary,
          colors: colors ??
              (type == ButtonType.secondary
                  ? [AppColors.secondary, AppColors.secondary.withOpacity(0.4)]
                  : null),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(AppDimension.componentHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimension.borderRadius),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: onPressed,
            child: _child,
          ),
        );
    }
  }
}
