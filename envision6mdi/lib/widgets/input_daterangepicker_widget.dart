import 'package:envision6mdi/extensions/string_extension.dart';
import 'package:envision6mdi/widgets/dialog/date_picker.dart';
import 'package:envision6mdi/widgets/txt_entryfield_widget.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class InputDateRangePickerWidget extends StatefulWidget {
  final DateTime dateStart;
  final DateTime dateEnd;
  final double? maxWidth;
  final Color borderColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(DateTime startDate, DateTime endDate) onDateChange;
  const InputDateRangePickerWidget(
      {super.key,
      required this.dateStart,
      required this.dateEnd,
      this.maxWidth,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor = EnvisionColor.borderColor,
      required this.onDateChange});

  @override
  State<InputDateRangePickerWidget> createState() =>
      _InputDateRangePickerWidgetState();
}

class _InputDateRangePickerWidgetState
    extends State<InputDateRangePickerWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.maxWidth ?? EnvisionSize.defaultInputWidth;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TxtEntryfieldWidget(
          maxWidth: 160,
          value: widget.dateStart.formatDateTimeDisplayDatePicker(),
          readOnly: true,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            Icons.calendar_today,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () async {
            DateTime? pickedDate = await DatePicker.showDatePicker(context,
                initialDate: widget.dateStart);
            DateTime startDate = widget.dateStart;
            DateTime endDate = widget.dateStart;

            startDate = pickedDate ?? widget.dateStart;
            if (widget.dateStart.isAfter(widget.dateEnd)) {
              endDate = widget.dateStart;
            }
            widget.onDateChange(startDate, endDate);
          },
        ),
        const Center(
          widthFactor: 2,
          child: SizedBox(
            width: 15,
            child: Divider(
              thickness: 3,
            ),
          ),
        ),
        TxtEntryfieldWidget(
          maxWidth: 160,
          value: widget.dateEnd.formatDateTimeDisplayDatePicker(),
          readOnly: true,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            Icons.calendar_today,
            size: 18,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () async {
            DateTime? pickedDate = await DatePicker.showDatePicker(context,
                initialDate: widget.dateEnd);
            DateTime startDate = widget.dateStart;
            DateTime endDate = widget.dateStart;

            endDate = pickedDate ?? widget.dateEnd;
            if (widget.dateEnd.isBefore(widget.dateStart)) {
              startDate = widget.dateEnd;
            }
            widget.onDateChange(startDate, endDate);
          },
        ),
        const SizedBox(width: 10),
        const SizedBox(
          width: EnvisionSize.widgetPadding,
        ),
      ],
    );
  }
}
