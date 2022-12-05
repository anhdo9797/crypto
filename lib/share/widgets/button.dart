import 'package:flutter/material.dart';

import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import 'package:s_crypto/share/utils/utils.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.type = ButtonType.primary,
    required this.onPressed,
    required this.label,
    this.child,
    this.icon,
    this.colors,
    this.labelStyle = const TextStyle(color: textDefault),
    this.backgroundColor,
    this.padding = 16.0,
  }) : super(key: key);

  final ButtonType type;
  final Function() onPressed;
  final String? label;
  final Widget? child;
  final Widget? icon;
  final List<Color>? colors;
  final Color? backgroundColor;
  final TextStyle labelStyle;
  final double padding;

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
                    color: blueColor,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
            ));
      case ButtonType.icon:
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? context.colors.primary,
                borderRadius: BorderRadius.circular(padding),
              ),
              padding: EdgeInsets.all(padding),
              child: icon,
            ),
          ),
        );
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
            side: BorderSide(color: context.colors.primary, width: 1),
          ),
          child: _child,
        );
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDimension.componentHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimension.borderRadius),
            ),
            backgroundColor: backgroundColor ?? context.colors.primary,
            // shadowColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: _child,
        );
    }
  }
}
