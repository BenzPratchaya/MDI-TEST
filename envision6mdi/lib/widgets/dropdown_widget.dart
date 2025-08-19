import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class DropdownListWidget extends StatelessWidget {
  const DropdownListWidget(
      {super.key,
      required this.defaultText,
      this.selectedItem,
      this.dropdownMenuItems,
      this.onChanged,
      this.maxWidth,
      this.borderColor = EnvisionColor.borderColor});
  final String defaultText;
  final dynamic selectedItem;
  final List<DropdownMenuItem>? dropdownMenuItems;
  final Function(dynamic)? onChanged;
  final double? maxWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
          border: Border.all(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
          color: EnvisionColor.backgroundColor2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width > width
                ? width
                : MediaQuery.of(context).size.width,
            // height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                // isDense: true
                dropdownColor: Colors.white,
                // focusColor: EnvisionColor.focusColor,
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                value: selectedItem,
                items: dropdownMenuItems,
                onChanged: onChanged,
                hint: Text(
                  defaultText,
                  // style: const TextStyle(
                  //   color: EnvisionColor.fontHintColor,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
