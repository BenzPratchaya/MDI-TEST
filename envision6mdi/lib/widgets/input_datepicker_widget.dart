import 'package:envision6mdi/extensions/string_extension.dart';
import 'package:envision6mdi/widgets/dialog/date_picker.dart';
import 'package:envision6mdi/widgets/txt_entryfield_widget.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class InputDatetimePickerWidget extends StatelessWidget {
  final String dateMask;
  final String dateLabel;
  final String? initialValue;
  final ValueChanged? onChanged;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final double? maxWidth;
  final Color borderColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final DateTime date;
  final Function(DateTime date) onDateChange;

  const InputDatetimePickerWidget(
      {super.key,
      this.dateMask = 'd MMM, yyyy',
      this.dateLabel = 'Date',
      this.initialValue,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.maxWidth,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      required this.onDateChange,
      required this.date});

  @override
  Widget build(BuildContext context) {
    double width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width > width
            ? width
            : MediaQuery.of(context).size.width,
        child: TxtEntryfieldWidget(
          maxWidth: 160,
          value: date.formatDateTimeDisplayDatePicker(),
          readOnly: true,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            Icons.calendar_today,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () async {
            DateTime? pickedDate =
                await DatePicker.showDatePicker(context, initialDate: date);

            onDateChange(pickedDate ?? date);
          },
        ),
      ),
    );
  }
}
