import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class DropdownListWidget<T> extends StatelessWidget {
  const DropdownListWidget({
    super.key,
    required this.defaultText,
    this.selectedItem,
    this.dropdownMenuItems,
    this.onChanged,
    this.maxWidth,
    this.borderColor = EnvisionColor.borderColor,
    this.isEnabled = true,
    this.icon,
    this.elevation = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 20.0),
  });

  final String defaultText;
  final T? selectedItem;
  final List<DropdownMenuItem<T>>? dropdownMenuItems;
  final Function(T?)? onChanged;
  final double? maxWidth;
  final Color borderColor;
  final bool isEnabled;
  final Widget? icon;
  final int elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double effectiveWidth = screenWidth > width ? width : screenWidth;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
        border: Border.all(
          color: isEnabled ? borderColor : borderColor.withOpacity(0.5),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        color: isEnabled 
            ? EnvisionColor.backgroundColor2 
            : EnvisionColor.backgroundColor2.withOpacity(0.5),
      ),
      child: SizedBox(
        width: effectiveWidth,
        child: Padding(
          padding: padding,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: selectedItem,
              items: dropdownMenuItems,
              onChanged: isEnabled ? onChanged : null,
              hint: Text(
                defaultText,
                style: TextStyle(
                  color: isEnabled 
                      ? EnvisionColor.fontHintColor 
                      : EnvisionColor.fontHintColor.withOpacity(0.5),
                ),
              ),
              icon: icon ?? const Icon(Icons.arrow_drop_down),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
              elevation: elevation,
              isExpanded: true,
              style: const TextStyle(
                color: EnvisionColor.darkFontColor,
                fontSize: 16,
              ),
              // Improve accessibility
              focusColor: EnvisionColor.focusColor.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }
}