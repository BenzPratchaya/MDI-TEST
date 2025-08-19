import 'package:envision6mdi/extensions/string_extension.dart';
import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/widgets/txt_entryfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker {
  static Future<DateTime?> showDatePicker(BuildContext context,
      {DateTime? initialDate, DateRangePickerView? view}) async {
    return await showDialog<DateTime?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Select date'),
          content: SizedBox(
            width: 500,
            height: 300,
            child: DatePickerWidget(
              initialDate: initialDate,
              view: view,
              onSelect: (DateTime datetime) {
                Navigator.pop(context, datetime);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime datetime) onSelect;
  final Function() onCancel;
  final DateTime? initialDate;
  final DateRangePickerView? view;
  const DatePickerWidget({
    super.key,
    required this.onSelect,
    required this.onCancel,
    this.initialDate,
    this.view,
  });

  @override
  State<StatefulWidget> createState() => _DatePickerWidget();
}

class _DatePickerWidget extends State<DatePickerWidget> {
  DateTime datetime = DateTime.now();
  bool dateinput = false;
  late FocusNode dateInputNode;

  @override
  void initState() {
    datetime = widget.initialDate ?? DateTime.now();
    dateInputNode = FocusNode();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(DateFormat(EnvisionFormat.displayFormattedDate).format(widget.initialDate));
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Select date',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 150,
              child: Text(
                datetime.formatDateTimeDisplayDatePicker(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            !dateinput
                ? IconButton(
                    onPressed: () {
                      dateinput = !dateinput;
                      dateInputNode.requestFocus();
                      setState(() {});
                    },
                    icon: const Icon(Icons.edit),
                  )
                : IconButton(
                    onPressed: () {
                      dateinput = !dateinput;
                      setState(() {});
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!dateinput)
                Expanded(
                  child: SfDateRangePicker(
                    showNavigationArrow: true,
                    showTodayButton: false,
                    initialSelectedDate: datetime,
                    initialDisplayDate: datetime,
                    view: widget.view ?? DateRangePickerView.month,
                    onSelectionChanged: (select) {
                      datetime = select.value;
                      setState(() {});
                    },
                    backgroundColor: Colors.transparent,
                    headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              if (dateinput)
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dd-MM-yyyy',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                        // DateFormatField(
                        //     addCalendar: false,
                        //     decoration: const InputDecoration(
                        //         border: OutlineInputBorder()),
                        //     type: DateFormatType.type4,
                        //     focusNode: dateInputNode,
                        //     onComplete: (date) {
                        //       if (date != null) {
                        //         datetime = date;
                        //         setState(() {});
                        //       }
                        //     }),
                        TxtEntryfieldWidget(
                          value: DateFormat(EnvisionFormat.displayFormattedDate)
                              .format(datetime),
                          filled: true,
                          fillColor: Colors.transparent,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          inputFormatters: [MaskedInputFormatter('00-00-0000')],
                          valueChanged: (date) {
                            if (date.toString().length == 10) {
                              try {
                                DateFormat format = DateFormat("dd-MM-yyyy");
                                datetime = format.parseStrict(date);
                                setState(() {});
                              } on Exception catch (_) {
                                setState(() {});
                                // throw Exception("Error  $date");
                              }
                            }
                            // datetime = date;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onCancel();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onSelect(datetime);
                    },
                    child: const Text('OK'),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
