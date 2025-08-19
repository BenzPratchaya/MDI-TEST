import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/responsive.dart';
import 'input_entry_field.dart';
import 'input_number_widget.dart';

class InputEntryInlineFieldWidget extends StatelessWidget {
  final String title;
  final dynamic value;
  final ValueChanged? valueChanged;
  final Function(String)? onSubmitted;
  final bool isPassword;
  final int? maxLine;
  final double? headerWidth;
  final double? maxWidth;
  final bool isEnabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color borderColor;
  final FocusNode? textFocus;
  final bool autofocus;
  final double? customFontSize;
  final String? inputType;
  final String? unit;

  //dropdown

  // final String? defaultText;
  // final String? searchText;
  // final dynamic selectedItem;
  // final List<DropdownMenuItem>? dropdownMenuItems;
  // final Function(dynamic)? onChanged;

  const InputEntryInlineFieldWidget(
      {super.key,
      required this.title,
      this.value,
      this.valueChanged,
      this.onSubmitted,
      this.customFontSize,
      this.headerWidth = 110,
      required this.isPassword,
      this.maxLine,
      this.maxWidth,
      this.isEnabled = true,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      this.textFocus,
      this.autofocus = false,
      this.inputType = 'text',
      this.unit});

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;

    final textController = TextEditingController();
    textController.text = value ?? '';
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
    return Container(
      alignment: Alignment.centerLeft,
      width: width,
      child: Responsive.isMobile(context) && inputType != 'checkbox'
          ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: inputType != 'checkbox'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    title,
                    style: EnvisionFormat.normalText,
                  ),
                  // const SizedBox(
                  //   width: 9,
                  // ),
                  getInput(context, unit == null ? maxWidth! : maxWidth! - 50),
                  unit != null
                      ? Container(
                          alignment: Alignment.center,
                          width: 50,
                          child: Text(unit!),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: headerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 3, 0),
                        child: Text(
                          title,
                          style: EnvisionFormat.normalText,
                        ),
                      ),
                    ],
                  ),
                ),
                getInput(
                    context,
                    unit == null
                        ? width - headerWidth!
                        : width - headerWidth! - 40),
                unit != null
                    ? Container(
                        alignment: Alignment.center,
                        width: 40,
                        child: Text(
                          unit!,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }

  Widget getInput(
    BuildContext context,
    double maxWidth,
  ) {
    double width = maxWidth;
    width = Responsive.isDesktop(context)
        ? width
        : MediaQuery.of(context).size.width - headerWidth!;
    double fontSize = customFontSize ?? EnvisionSize.defaultFontSize;
    if (inputType == 'number') {
      return InputNumberWidget(
          customFontSize: fontSize,
          title: title,
          value: value,
          valueChanged: valueChanged,
          onSubmitted: onSubmitted,
          maxLine: maxLine,
          maxWidth: maxWidth,
          isEnabled: isEnabled,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          borderColor: borderColor,
          autofocus: autofocus);
    } else if (inputType == 'double') {
      return InputNumberWidget(
          customFontSize: fontSize,
          title: title,
          isDouble: true,
          value: value,
          valueChanged: valueChanged,
          onSubmitted: onSubmitted,
          maxLine: maxLine,
          maxWidth: maxWidth,
          isEnabled: isEnabled,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          borderColor: borderColor,
          autofocus: autofocus);
    } else if (inputType == 'checkbox') {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        width: maxWidth,
        alignment: Alignment.centerLeft,
        child: Checkbox(
          value: value == '1' ? true : false,
          onChanged: valueChanged,
        ),
      );
    } else {
      return InputEntryFieldWidget(
          customFontSize: fontSize,
          title: title,
          value: value,
          valueChanged: valueChanged,
          onSubmitted: onSubmitted,
          isPassword: isPassword,
          maxLine: maxLine,
          maxWidth: maxWidth,
          isEnabled: isEnabled,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          borderColor: borderColor,
          textFocus: textFocus,
          autofocus: autofocus);
    }
  }
}
