import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final String? label;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: isObscure,
        maxLength: 25,
        keyboardType: inputType,
        style: Theme.of(context).textTheme.bodyText1,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          label: label != null ? Text(label ?? "") : null,
          hintText: hint,
          hintStyle:
              Theme.of(context).textTheme.bodyText1!.copyWith(color: hintColor),
          errorText: errorText,
          counterText: '',
          errorStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
        ),
        validator: validator,
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    required this.textController,
    this.errorText,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.label,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);
}
