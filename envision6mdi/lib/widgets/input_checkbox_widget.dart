import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class InputCheckBoxWidget extends StatelessWidget {
  const InputCheckBoxWidget(
      {super.key,
      required this.title,
      this.value,
      this.valueChanged,
      this.maxWidth});

  final String title;
  final bool? value;
  final ValueChanged? valueChanged;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width > width
                ? width
                : MediaQuery.of(context).size.width,
            child: CheckboxListTile(
              title: Text(title),
              value: value,
              onChanged: valueChanged,
            )));
  }
}
