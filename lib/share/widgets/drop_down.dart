import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/constants/dimension.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget(
      {Key? key, required this.value, required this.items, this.onChanged})
      : super(key: key);

  final T value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppDimension.padding / 4),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
        value: value,
        isDense: true,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        onChanged: onChanged,
        items: items,
      )),
    );
  }
}
