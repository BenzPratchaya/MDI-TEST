import 'package:envision6mdi/extensions/string_extension.dart';
import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/helpers/save_file_web.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/models/mdi/organization_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/providers/user_provider.dart';
import 'package:envision6mdi/widgets/container_widget.dart';
import 'package:envision6mdi/widgets/header_widget.dart';
import 'package:envision6mdi/widgets/input_daterangepicker_widget.dart';

import 'package:envision6mdi/widgets/round_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

class MDIReportDataPage extends StatefulWidget {
  final String? subLocationUid;
  const MDIReportDataPage({super.key, this.subLocationUid});

  @override
  State<MDIReportDataPage> createState() => _MDIReportDataPageState();
}

class _MDIReportDataPageState extends State<MDIReportDataPage> {
  DateTime startDate = DateTime.now(); //
  DateTime endDate = DateTime.now();
  String hn = '';
  String subLocationUid = '';
  bool isSearchDateTime = true;

  late List<MdiDataViewModel> worklist = [];
  late List<MdiDataViewModel> worklistView = [];

  late bool isLoadingData = true;
  late int increment = 10;
  final _scrollController = ScrollController();
  final tableHorizontalScrollController = ScrollController();
  String message = "";

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          worklist.length > worklistView.length) {
        setState(() {
          isLoadingData = true;
        });
        _loadMoreData(worklist);
      }
    });
    super.initState();
  }

  Future _loadMoreData(List<MdiDataViewModel> worklist) async {
    isLoadingData = true;
    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));
    var inc = increment;
    if (worklist.length < increment) {
      inc = worklist.length;
      setState(() {
        worklistView = [];
      });
    } else if (worklist.length - worklistView.length < increment) {
      inc = worklist.length - worklistView.length;
    }
    setState(() {
      worklistView.addAll(
          List.generate(inc, (index) => worklist[worklistView.length + index]));
      isLoadingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)!;
    final orgId = user.user.organizationId ?? 1;
    subLocationUid = widget.subLocationUid ?? '';
    return Scaffold(
      body: ViewModelBuilder<MdiViewModel>.reactive(
        viewModelBuilder: () => MdiViewModel(),
        onViewModelReady: (model) =>
            model.prepareWorklistData(startDate, endDate, orgId).then((value) {
          worklist = model.worklist;
          _loadMoreData(model.worklist);
        }),
        builder: (context, model, child) => SafeArea(
          child: Column(
            children: [
              HeaderWidget(
                organizationList: model.organizationList,
                showSearch: false,
                title: 'Envision MDI $subLocationUid ',
                onOrgChanged: (Organization value) => {
                  model
                      .prepareWorklistData(startDate, endDate, orgId)
                      .then((value) {
                    worklist = model.worklist;
                    _loadMoreData(model.worklist);
                  })
                },
              ),
              Expanded(
                child: ContainerWidget(
                  borderRadius: 0,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: EnvisionSize.inputPadding,
                      ),
                      _searchPanel(model, context, orgId),
                      // _worklistPanel(model, context, orgId),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchPanel(MdiViewModel model, BuildContext context, int orgId) {
    return ContainerWidget(
      // background: EnvisionColor.colorBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data use per day'),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputDateRangePickerWidget(
                dateStart: startDate,
                dateEnd: endDate,
                onDateChange: (DateTime startDate, DateTime endDate) {
                  setState(() {
                    this.startDate = startDate;
                    this.endDate = endDate;
                  });
                },
              ),
              const SizedBox(width: 10),
              const SizedBox(
                width: EnvisionSize.widgetPadding,
              ),
              RoundButtonWidget(
                onTap: () async {
                  worklistView = [];
                  isLoadingData = true;
                  setState(() {});

                  await model.getSelectByDateGroupByModality(
                      startDate, endDate, orgId);
                  generateExcel(model);
                  // _loadMoreData(model.worklist);
                },
                title: 'Export Data',
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget switchButton(String text, bool isDisable) {
    return TextButton(
        onPressed: () {
          if (isDisable) {
            setState(() {
              isSearchDateTime = !isSearchDateTime;
            });
          }
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                isDisable ? EnvisionColor.colorGrey : EnvisionColor.colorGreen),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Text(
          text,
          style: TextStyle(
              color: isDisable
                  ? EnvisionColor.primaryColor
                  : EnvisionColor.colorGrey),
        ));
  }

  Future<void> generateExcel(MdiViewModel model) async {
    final Workbook workbook = Workbook();
    List<String> column = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];
    final Worksheet sheet = workbook.worksheets[0];

    List<String> columnName = [
      'date',
      'location',
      'modality',
      'count',
    ];
    // Enable calculation for worksheet.
    // var column = 0;
    sheet.enableSheetCalculations();
    for (var i = 0; i < columnName.length; i++) {
      sheet.getRangeByIndex(1, i + 1).columnWidth = 15;
      sheet.getRangeByName('${column[i]}1').setText(columnName[i]);
    }

    for (var i = 0; i < model.datalistGroupByModality.length; i++) {
      var j = 1;
      sheet.getRangeByIndex(2 + i, j++).setText(
          model.datalistGroupByModality[i].date!.formatDateTimeDisplay());
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.datalistGroupByModality[i].location ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.datalistGroupByModality[i].modality ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.datalistGroupByModality[i].count.toString());
    }

    final List<int> bytes = workbook.saveAsStream();

    workbook.dispose();

    String formattedDate =
        '${startDate.formatDateTimeSave()}_${endDate.formatDateTimeSave()}';

    await saveAndLaunchFile(bytes, 'MDI_$formattedDate.xlsx');
  }
}
