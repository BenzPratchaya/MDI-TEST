import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:envision6mdi/extensions/string_extension.dart';

import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/helpers/save_file_web.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/models/mdi/organization_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/pages/mdi/mdi_worklist/mdi_worklist_table.dart';
import 'package:envision6mdi/providers/user_provider.dart';
import 'package:envision6mdi/widgets/container_widget.dart';
import 'package:envision6mdi/widgets/header_widget.dart';
import 'package:envision6mdi/widgets/input_daterangepicker_widget.dart';
import 'package:envision6mdi/widgets/input_entry_inline_field.dart';
import 'package:envision6mdi/widgets/round_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

class MDIWorklistPage extends StatefulWidget {
  final String? subLocationUid;
  const MDIWorklistPage({super.key, this.subLocationUid});

  @override
  State<MDIWorklistPage> createState() => _MDIWorklistPageState();
}

class _MDIWorklistPageState extends State<MDIWorklistPage> {
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
              ContainerWidget(
                borderRadius: 0,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    _searchPanel(model, context, orgId),
                    const SizedBox(
                      height: EnvisionSize.inputPadding,
                    ),
                    _worklistPanel(model, context, orgId),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _worklistPanel(MdiViewModel model, BuildContext context, int orgId) {
    var height = isLoadingData
        ? MediaQuery.of(context).size.height - 277 - 13
        : MediaQuery.of(context).size.height - 273 - 13;
    return Column(
      children: [
        ContainerWidget(
            alignment: Alignment.topLeft,
            height: height,
            child: AdaptiveScrollbar(
              controller: tableHorizontalScrollController,
              width: 15,
              position: ScrollbarPosition.bottom,
              sliderActiveDecoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              sliderDecoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: tableHorizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: MdiWorklistTable(
                    model: model,
                    onDataChanged: (List<MdiDataViewModel> value) async {
                      isSearchDateTime
                          ? await model.getSelectViewByDate(
                              startDate, endDate, orgId)
                          : await model.getSelectDataViewByHn(hn);
                      worklistView = [];
                      worklist = value;
                      _loadMoreData(worklist);
                      // worklist = value;
                      // worklistView = [];
                      // _loadMoreData(value);
                    },
                    worklist: worklistView,
                    onLoadMore: (bool value) {
                      _loadMoreData(worklist);
                    },
                  ),
                  // child: const SizedBox(),
                ),
              ),
            )),
        isLoadingData
            // && worklist.length > worklistView.length
            ? const LinearProgressIndicator()
            : const SizedBox(),
        Container(
          margin: const EdgeInsets.fromLTRB(0, EnvisionSize.inputPadding, 0, 0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${worklistView.length} of ${worklist.length}',
                style: const TextStyle(
                    color: EnvisionColor.fontHintColor,
                    fontSize: EnvisionSize.smallFontSize),
              ),
              worklist.length > worklistView.length
                  ? TextButton.icon(
                      // <-- TextButton
                      onPressed: () {
                        setState(() {
                          isLoadingData = true;
                        });
                        _loadMoreData(worklist);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        // size: 24.0,
                      ),
                      label: const Text('Load more'),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchPanel(MdiViewModel model, BuildContext context, int orgId) {
    return ContainerWidget(
      // background: EnvisionColor.colorBlue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Search by'),
                  const SizedBox(
                    width: EnvisionSize.cardPadding,
                  ),
                  switchButton(
                    'Date',
                    !isSearchDateTime,
                  ),
                  const SizedBox(
                    width: EnvisionSize.cardPadding,
                  ),
                  switchButton(
                    'HN',
                    isSearchDateTime,
                  ),
                ],
              ),
              const SizedBox(
                height: EnvisionSize.inputPadding,
              ),
              Row(
                children: [
                  isSearchDateTime
                      ? InputDateRangePickerWidget(
                          dateStart: startDate,
                          dateEnd: endDate,
                          onDateChange: (DateTime startDate, DateTime endDate) {
                            setState(() {
                              this.startDate = startDate;
                              this.endDate = endDate;
                            });
                          },
                        )
                      : InputEntryInlineFieldWidget(
                          headerWidth: 50,
                          maxWidth: 300,
                          isPassword: false,
                          title: 'HN',
                          value: hn,
                          valueChanged: (value) {
                            setState(() {
                              hn = value;
                            });
                          }),
                  const SizedBox(
                    width: EnvisionSize.widgetPadding,
                  ),
                  RoundButtonWidget(
                      onTap: () async {
                        worklistView = [];
                        isLoadingData = true;
                        setState(() {});
                        isSearchDateTime
                            ? await model.getSelectViewByDate(
                                startDate, endDate, orgId)
                            : await model.getSelectDataViewByHn(hn);
                        _loadMoreData(model.worklist);
                      },
                      title: 'Search')
                ],
              )
            ],
          ),
          Row(
            children: [
              // const Text('Export Excel'),
              IconButton(
                icon: const ImageIcon(
                  AssetImage("images/excel.png"),
                  color: EnvisionColor.colorGreen,
                ),
                tooltip: 'export to excel',
                onPressed: () {
                  generateExcel(model);
                },
              ),
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
              // side: BorderSide(color: Colors.red)
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
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];

    List<String> columnName = [
      'Create On',
      'HN',
      'Patient Name',
      'Visit',
      'Age',
      'Gender',
      'patient Type',
      'Weight',
      'Height',
      'BMI',
      'blood Pressure',
      'pulse Rate',
      'Respiration Rate',
      'Temperature',
      'spo2',
      'Pain Scale',
      'coma E Score',
      'coma V Score',
      'coma M Score',
      'Smoking Status',
      'Smoking Hsi',
      'CvRisk Score',
      'Fall Risk Type',
      'Status',
      'Location',
      'Modality Wh'
    ];
    // Enable calculation for worksheet.
    var column = 0;
    sheet.enableSheetCalculations();
    sheet.getRangeByName('A1').setText(columnName[column++]);
    sheet.getRangeByName('B1').setText(columnName[column++]);
    sheet.getRangeByName('C1').setText(columnName[column++]);
    sheet.getRangeByName('D1').setText(columnName[column++]);
    sheet.getRangeByName('E1').setText(columnName[column++]);
    sheet.getRangeByName('F1').setText(columnName[column++]);
    sheet.getRangeByName('G1').setText(columnName[column++]);
    sheet.getRangeByName('H1').setText(columnName[column++]);
    sheet.getRangeByName('I1').setText(columnName[column++]);
    sheet.getRangeByName('J1').setText(columnName[column++]);
    sheet.getRangeByName('K1').setText(columnName[column++]);
    sheet.getRangeByName('L1').setText(columnName[column++]);
    sheet.getRangeByName('M1').setText(columnName[column++]);
    sheet.getRangeByName('N1').setText(columnName[column++]);
    sheet.getRangeByName('O1').setText(columnName[column++]);
    sheet.getRangeByName('P1').setText(columnName[column++]);
    sheet.getRangeByName('Q1').setText(columnName[column++]);
    sheet.getRangeByName('R1').setText(columnName[column++]);
    sheet.getRangeByName('S1').setText(columnName[column++]);
    sheet.getRangeByName('T1').setText(columnName[column++]);
    sheet.getRangeByName('U1').setText(columnName[column++]);
    sheet.getRangeByName('V1').setText(columnName[column++]);
    sheet.getRangeByName('W1').setText(columnName[column++]);
    sheet.getRangeByName('X1').setText(columnName[column++]);
    sheet.getRangeByName('Y1').setText(columnName[column++]);
    sheet.getRangeByName('Z1').setText(columnName[column++]);

    for (var i = 0; i < model.worklist.length; i++) {
      var j = 1;
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].createdOn!.formatDateTimeDisplay());
      sheet.getRangeByIndex(2 + i, j++).setText(model.worklist[i].hn ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientName ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].visitNo ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientAgeText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientGenderText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientTypeText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientWeightText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].patientHeightText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText('${model.worklist[i].patientBmi ?? ''}');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].bloodPressureText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].pulseRateText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText('${model.worklist[i].respirationRate ?? ''}');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].temperatureText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].spo2Text ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText('${model.worklist[i].painScale ?? ''}');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].comaEScoreText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].comaVScoreText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].comaMScoreText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].smokingStatusText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText('${model.worklist[i].smokingHsi ?? ''}');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText('${model.worklist[i].cvRiskScore ?? ''}');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].fallRiskTypeText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].dataStatusText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].locationText ?? '');
      sheet
          .getRangeByIndex(2 + i, j++)
          .setText(model.worklist[i].modalityWhText ?? '');
    }
    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    //Save and launch the file.
    // DateTime now = DateTime.now();
    String formattedDate =
        '${startDate.formatDateTimeSave()}_${endDate.formatDateTimeSave()}';

    await saveAndLaunchFile(bytes, 'MDI_$formattedDate.xlsx');
  }
}
