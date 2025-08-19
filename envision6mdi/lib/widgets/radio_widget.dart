import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0),
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final dynamic groupValue;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (value != groupValue) {
        onChanged(value);
        // }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<dynamic>(
              groupValue: groupValue,
              value: value,
              onChanged: (dynamic newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
