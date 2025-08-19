import 'package:flutter/material.dart';

class InputSearchInTableWidget extends StatelessWidget {
  final String columnName;

  const InputSearchInTableWidget({
    super.key,
    this.onSearchChaged,
    required this.columnName,
    this.width,
    this.prefixIcon = const Icon(Icons.search),
    this.readOnly = false,
  });
  final Function(String)? onSearchChaged;
  final double? width;
  final Widget? prefixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            width: width ?? 150,
            child: TextField(
                readOnly: readOnly,
                onChanged: onSearchChaged,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: prefixIcon,
                    contentPadding: const EdgeInsets.only(left: 30),
                    labelText: columnName,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1.0, style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1.0, style: BorderStyle.solid))
                    // hintText: hintText,
                    ))),
      ],
    );
  }
}
