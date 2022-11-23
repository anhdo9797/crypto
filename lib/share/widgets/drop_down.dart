import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget(
      {Key? key, required this.value, required this.items, this.onChanged})
      : super(key: key);

  final T value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          onChanged: onChanged,
          items: items,
        )),
      ),
    );
  }
}
