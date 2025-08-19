import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/constants.dart';

class FormattedNumberFeild extends StatelessWidget {
  const FormattedNumberFeild(
      {super.key,
      this.onChange,
      this.label,
      this.initialValue,
      required this.format,
      this.separator = ' ',
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      this.borderFocusColor = EnvisionColor.focusColor,
      this.maxWidth,
      this.isEnabled = true});
  final Function? onChange;
  final String format;
  final String separator;
  final String? label;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color borderColor;
  final Color borderFocusColor;
  final double? maxWidth;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    final textController = TextEditingController();
    textController.text = getInitialFormattedNumber(format, initialValue ?? '');
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width > width
            ? width
            : MediaQuery.of(context).size.width,
        child: TextFormField(
          // toolbarOptions: const ToolbarOptions(
          //   copy: true,
          //   cut: true,
          //   paste: false,
          //   selectAll: false,
          // ),
          enabled: isEnabled,
          cursorColor: EnvisionColor.cursorColor,
          maxLines: 1,
          controller: textController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9$separator]")),
            MaskedTextInputFormatter(
              mask: format,
              separator: separator,
            ),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterText: "",
            // isDense: true,
            labelText: label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                borderSide: BorderSide(
                    color: borderFocusColor,
                    width: 1.0,
                    style: BorderStyle.solid)),
            hintStyle: const TextStyle(
              color: EnvisionColor.fontHintColor,
            ),
          ),
          onChanged: (value) {
            onChange!(value.replaceAll(separator, ""));
          },
        ),
      ),
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;
  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

getInitialFormattedNumber(String format, String str) {
  if (str == '') return '';
  var mask = format;
  str.split("").forEach((item) => mask = mask.replaceFirst('x', item));
  return mask.replaceAll('x', "");
}
