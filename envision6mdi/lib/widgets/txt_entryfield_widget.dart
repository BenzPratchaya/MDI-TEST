import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BorderStyleMode {
  defaultTheme,
  defaultEntryField,
  zero,
  one,
  two,
  incard,
  isRequired
}

class TxtEntryfieldWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final ValueChanged? valueChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final String? hintText;
  final bool isPassword;
  final int? maxLength;
  final int? maxLine;
  final double? maxWidth;
  final bool isEnabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final BorderStyleMode borderMode;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final double radius;
  final bool autofocus;
  final bool filled;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDense;
  final TextEditingController? textController;
  final Function(PointerDownEvent)? onTapOutside;

  const TxtEntryfieldWidget({
    super.key,
    this.title,
    this.value,
    this.valueChanged,
    this.onSubmitted,
    this.onTap,
    this.hintText,
    this.isPassword = false,
    this.maxLength,
    this.maxLine,
    this.maxWidth,
    this.isEnabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.borderMode = BorderStyleMode.defaultTheme,
    this.enabledBorder,
    this.focusedBorder,
    this.radius = 15,
    this.autofocus = false,
    this.filled = true,
    this.fillColor,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.textAlign = TextAlign.left,
    this.style,
    this.contentPadding,
    this.isDense = false,
    this.textController,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidthData = maxWidth ?? 400;
    var controller = TextEditingController();
    if (textController == null) {
      controller.text = value ?? '';
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    } else {
      controller = textController!;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width > maxWidthData
              ? maxWidthData
              : MediaQuery.sizeOf(context).width,
          child: TextField(
              style: style,
              textAlign: textAlign,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              autofocus: autofocus,
              enabled: isEnabled,
              readOnly: readOnly,
              controller: value == null ? null : controller,
              onChanged: valueChanged,
              onSubmitted: onSubmitted,
              onTap: onTap,
              obscureText: isPassword,
              maxLines: maxLine ?? 1,
              maxLength: maxLength,
              scrollPadding: const EdgeInsets.only(left: 10),
              onTapOutside: onTapOutside,
              decoration: InputDecoration(
                isDense: isDense,
                filled: filled,
                fillColor: fillColor,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                contentPadding: contentPadding ??
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                labelText: title,
                disabledBorder: enabledBorder ?? _border(context),
                enabledBorder: enabledBorder ?? _border(context),
                focusedBorder: focusedBorder ?? _border(context),
                hintText: hintText,
              ))),
    );
  }

  _border(BuildContext context) {
    InputBorder? borderResult;
    switch (borderMode) {
      case BorderStyleMode.defaultTheme:
        borderResult = null;
        break;
      case BorderStyleMode.defaultEntryField:
        borderResult = OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
                // color: borderColor ?? context.themeData.primaryColor,
                width: 1.0,
                style: BorderStyle.solid));
        break;
      case BorderStyleMode.zero:
        borderResult = InputBorder.none;
        break;
      case BorderStyleMode.one:
        borderResult = OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
                // color: borderColor ?? context.themeData.primaryColor,
                width: 1.0,
                style: BorderStyle.solid));
        break;
      case BorderStyleMode.two:
        borderResult = null;
        break;
      case BorderStyleMode.incard:
        borderResult = OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
          borderSide: const BorderSide(width: 1, color: Color(0xFF292C38)),
        );
        break;
      case BorderStyleMode.isRequired:
        borderResult = OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8),
                width: 1.0,
                style: BorderStyle.solid));
        break;
      default:
        borderResult = null;
    }
    return borderResult;
  }
}
