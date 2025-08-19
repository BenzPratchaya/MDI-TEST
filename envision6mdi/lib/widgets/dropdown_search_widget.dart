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
      this.isEnabled = true,
      this.searchText,
      this.borderColor = EnvisionColor.borderColor});
  final String defaultText;
  final String? searchText;
  final dynamic selectedItem;
  final List<DropdownMenuItem>? dropdownMenuItems;
  final Function(dynamic)? onChanged;
  final double? maxWidth;
  final Color borderColor;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
          border: Border.all(
              color: isEnabled
                  ? EnvisionColor.colorBlue
                  : const Color.fromARGB(255, 193, 193, 193),
              width: 1.0,
              style: BorderStyle.solid),
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
                isDense: true,
                isExpanded: true,
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                dropdownColor: Colors.white,
                // focusColor: EnvisionColor.focusColor,
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                value: selectedItem,
                items: dropdownMenuItems,
                onChanged: isEnabled ? onChanged : null,
                hint: SizedBox(
                  width: width - 24,
                  child: Text(
                    defaultText,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: EnvisionFormat.normalText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
