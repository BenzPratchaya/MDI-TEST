import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class InputEntryFieldWidget extends StatelessWidget {
  final String title;
  final String? value;
  final ValueChanged? valueChanged;
  final Function(String)? onSubmitted;
  final bool isPassword;
  final int? maxLine;
  final double? maxWidth;
  final bool isEnabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color borderColor;
  final FocusNode? textFocus;
  final bool autofocus;
  final double? customFontSize;
  final TextEditingController? controller;

  const InputEntryFieldWidget(
      {super.key,
      required this.title,
      this.value,
      this.valueChanged,
      this.onSubmitted,
      this.customFontSize,
      required this.isPassword,
      this.maxLine,
      this.maxWidth,
      this.isEnabled = true,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      this.textFocus,
      this.autofocus = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    double fontSize = customFontSize ?? EnvisionSize.defaultFontSize;
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    final textController = controller ?? TextEditingController();
    textController.text = value ?? '';
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: SizedBox(
          width: MediaQuery.of(context).size.width > width
              ? width
              : MediaQuery.of(context).size.width,
          child: TextField(
              focusNode: textFocus,
              autofocus: autofocus,
              cursorColor: EnvisionColor.cursorColor,
              enabled: isEnabled,
              controller: textController,
              onChanged: valueChanged,
              onSubmitted: onSubmitted,
              obscureText: isPassword,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isEnabled
                    ? EnvisionColor.colorBlue
                    : EnvisionColor.disabledColor,
              ),
              maxLines: maxLine ?? 1,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 5.0, end: 5.0),
                filled: true,
                fillColor: borderColor == EnvisionColor.borderColor
                    ? Colors.white
                    : borderColor.withOpacity(0.1),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                // labelText: title,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(EnvisionSize.borderRadius),
                    borderSide: BorderSide(
                        color: borderColor,
                        width: 1.0,
                        style: BorderStyle.solid)),
                disabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(EnvisionSize.borderRadius),
                    borderSide: const BorderSide(
                        color: EnvisionColor.disabledColor,
                        width: 1.0,
                        style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(EnvisionSize.borderRadius),
                    borderSide: const BorderSide(
                        color: EnvisionColor.focusColor,
                        width: 1.0,
                        style: BorderStyle.solid)),
                hintText: title,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
              ))),
    );
  }
}
