import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../helpers/constants.dart';

class InputNumberWidget extends StatelessWidget {
  final String title;
  final String? value;
  final ValueChanged? valueChanged;
  final Function(String)? onSubmitted;
  final int? maxLine;
  final double? maxWidth;
  final bool isEnabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color borderColor;
  final Color borderFocusColor;
  final bool autofocus;
  final bool isDouble;
  final double? customFontSize;

  const InputNumberWidget(
      {super.key,
      required this.title,
      this.value,
      this.valueChanged,
      this.onSubmitted,
      this.maxLine,
      this.customFontSize,
      this.maxWidth,
      this.isEnabled = true,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      this.borderFocusColor = EnvisionColor.focusColor,
      this.autofocus = false,
      this.isDouble = false});

  @override
  Widget build(BuildContext context) {
    double fontSize = customFontSize ?? EnvisionSize.defaultFontSize;
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    final textController = TextEditingController();
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
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isEnabled
                    ? EnvisionColor.colorBlue
                    : EnvisionColor.disabledColor,
              ),
              autofocus: autofocus,
              cursorColor: EnvisionColor.cursorColor,
              enabled: isEnabled,
              controller: textController,
              keyboardType: isDouble
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                isDouble
                    ? FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}'))
                    : FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: valueChanged,
              onSubmitted: onSubmitted,
              maxLines: maxLine ?? 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: borderColor == EnvisionColor.borderColor
                    ? Colors.white
                    : borderColor.withOpacity(0.1),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                // labelText: title,
                isDense: true,
                contentPadding: const EdgeInsetsDirectional.only(
                    top: 10.0, bottom: 10.0, start: 5.0, end: 5.0),
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
                // hintText: title,
                hintStyle: const TextStyle(
                  color: EnvisionColor.fontHintColor,
                ),
              ))),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
