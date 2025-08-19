// ignore_for_file: use_build_context_synchronously
import 'dart:ui';

import 'package:envision6mdi/controllers/mdi_insert_controller.dart';
import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/gbl_general_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/pages/mdi/mdi_insert_page/popup_search_patient.dart';
import 'package:envision6mdi/providers/user_provider.dart';
import 'package:envision6mdi/widgets/container_widget.dart';
import 'package:envision6mdi/widgets/dropdown_search_widget.dart';
import 'package:envision6mdi/widgets/input_entry_inline_field.dart';
import 'package:envision6mdi/widgets/input_number_widget.dart';
import 'package:envision6mdi/widgets/txt_entryfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MdiFormConfirm extends StatefulWidget {
  final BuildContext context;
  final MdiViewModel model;
  final MdiDataViewModel mdiData;
  final ValueChanged<List<MdiDataViewModel>> onDataChanged;
  const MdiFormConfirm(
      {super.key,
      required this.onDataChanged,
      required this.context,
      required this.model,
      required this.mdiData});

  @override
  State<MdiFormConfirm> createState() => _MdiFormConfirmState();
}

class _MdiFormConfirmState extends State<MdiFormConfirm> {
  late MdiInsertController provider;
  late double inputWidth = 305;
  late double headerInputWidth = 130;
  late MdiDataViewModel mdiData = MdiDataViewModel();
  late MdiViewModel model = MdiViewModel();
  late String hn = '';
  // late String comment = '';
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusEnterNode = FocusNode();
  String _strReason = '';
  // final HtmlEditorController _remarkController = HtmlEditorController();
  //list
  late List<GblGeneralModel> smokeStatusList = [];
  late List<GblGeneralModel> comaEScore = [];
  late List<GblGeneralModel> comaVScore = [];
  late List<GblGeneralModel> comaMScore = [];
  late List<GblGeneralModel> fallRiskTypeList = [];

  late bool canEdit = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusEnterNode.requestFocus();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      mdiData = widget.mdiData;
      // print(mdiData.comment);
      // _remarkController.setText(convertPlainToHtml(mdiData.comment ?? ''));
      // _remarkController.getText().then((value) => print('value $value'));
      // print(mdiData.comment);
      await context.read<MdiInsertController>().toggleLoading();
      await context.read<MdiInsertController>().setDataToInsertForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MdiInsertController>(context, listen: false);
    inputWidth = MediaQuery.of(context).size.width > 1370 ? 330 : 225;

    // _remarkController.setText(convertPlainToHtml(mdiData.comment ?? ''));
    _strReason = mdiData.comment ?? '';
    return ViewModelBuilder<MdiViewModel>.reactive(
        viewModelBuilder: () => MdiViewModel(),
        onViewModelReady: (model) => model
                .prepareEditData(
                    Provider.of<UserProvider?>(context)!.user.organizationId ??
                        1)
                .then(
              (value) {
                // modality = model.modality;
                // org = model.organization;
                smokeStatusList = model.smokeStatusList;
                comaEScore = model.comaEScore;
                comaVScore = model.comaVScore;
                comaMScore = model.comaMScore;
                fallRiskTypeList = model.fallRiskTypeList;
                setState(() {});
                context.read<MdiInsertController>().setDataFrequency();
                context.read<MdiInsertController>().toggleLoading();
              },
            ),
        builder: (context, model, child) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: AlertDialog(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                            mdiData.isConfirmed == 1
                                ? 'Confirmed'
                                : 'This data is not confirm yet ',
                            style: const TextStyle(
                              fontFamily: 'TTNorms',
                              fontWeight: FontWeight.bold,
                              wordSpacing: 0,
                              letterSpacing: 0,
                              fontSize: 25,
                            )),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: const Color.fromARGB(255, 255, 255, 255),
                          textColor: EnvisionColor.colorBlue,
                          padding: const EdgeInsets.all(16),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.close,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    // var height = MediaQuery.of(context).size.height;
                    // var width = MediaQuery.of(context).size.width;
                    return ColoredBox(
                      color: Colors.white,
                      child: insertForm(),
                    );
                  },
                ),
                actions: const <Widget>[
                  SizedBox(
                    height: 40,
                    width: 150,
                  )
                ],
              ));
        });
  }

  Widget insertForm() {
    // var selectPatTypeList =
    //     patTypeList.where((e) => e.generalUid == mdiData.patientType).toList();
    // var selectPatType =
    //     selectPatTypeList.isNotEmpty ? selectPatTypeList.first : null;
    var selectComaEScoreList = comaEScore
        .where((e) => e.generalUid == mdiData.comaEScore.toString())
        .toList();
    var selectComaEScore =
        selectComaEScoreList.isNotEmpty ? selectComaEScoreList.first : null;
    var selectComaVScoreList = comaVScore
        .where((e) => e.generalUid == mdiData.comaVScore.toString())
        .toList();
    var selectComaVScore =
        selectComaVScoreList.isNotEmpty ? selectComaVScoreList.first : null;
    var selectComaMScoreList = comaMScore
        .where((e) => e.generalUid == mdiData.comaMScore.toString())
        .toList();
    var selectComaMScore =
        selectComaMScoreList.isNotEmpty ? selectComaMScoreList.first : null;
    var selectSmokingStatusList = smokeStatusList
        .where((e) => e.generalUid == mdiData.smokingStatus)
        .toList();
    var selectSmokingStatus = selectSmokingStatusList.isNotEmpty
        ? selectSmokingStatusList.first
        : null;
    double width = MediaQuery.of(context).size.width > 1500
        ? 1500
        : MediaQuery.of(context).size.width;
    var selectFallRiskTypeList = fallRiskTypeList
        .where((e) => e.generalId == mdiData.fallRiskType)
        .toList();
    var selectFallRiskType =
        selectFallRiskTypeList.isNotEmpty ? selectFallRiskTypeList.first : null;
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                context.watch<MdiInsertController>().isRefresh
                    ? Center(
                        child: ContainerWidget(
                            height: MediaQuery.of(context).size.height - 500,
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 100,
                            )),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContainerWidget(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: inputWidth + 50,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Visibility(
                                      //   visible: context
                                      //       .watch<MdiInsertController>()
                                      //       .isLoadingHn,
                                      //   replacement: Container(
                                      //     width: 60,
                                      //   ),
                                      //   child: SizedBox(
                                      //     width: 60,
                                      //     child: LoadingAnimationWidget.inkDrop(
                                      //       size: 20,
                                      //       color: Colors.blue,
                                      //     ),
                                      //   ),
                                      // ),
                                      InputEntryInlineFieldWidget(
                                        isEnabled: canEdit,
                                        headerWidth: headerInputWidth,
                                        maxWidth: inputWidth - 54,
                                        isPassword: false,
                                        title: 'HN',
                                        textFocus: _focusNode,
                                        value: mdiData.hn,
                                        valueChanged: (value) {
                                          setState(() {
                                            mdiData.hn = value;
                                          });
                                        },
                                        onSubmitted: (value) async {
                                          _searchHN(value);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          if (mdiData.hn != null) {
                                            _searchHN(mdiData.hn!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: inputWidth + 50,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InputEntryInlineFieldWidget(
                                        isEnabled: canEdit,
                                        headerWidth: headerInputWidth,
                                        maxWidth: inputWidth - 50,
                                        isPassword: false,
                                        title: 'VN',
                                        value: mdiData.visitNo,
                                        valueChanged: (value) {
                                          setState(() {
                                            mdiData.visitNo = value;
                                          });
                                        },
                                        onSubmitted: (value) async {
                                          context
                                              .read<MdiInsertController>()
                                              .setMessage('');

                                          if (value != '') {
                                            mdiData = MdiDataViewModel(
                                                visitNo: value);
                                            await model
                                                .getSelectDataByVN(
                                                    value,
                                                    provider.organization
                                                        .organizationId!)
                                                .then((value) {
                                              if (model.data.hn != null) {
                                                mdiData = model.data;
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessageLastUpdate(
                                                        DateTime.now());
                                              } else {
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessage(
                                                        'waiting data VN: ${mdiData.visitNo}');
                                              }
                                            });
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          context
                                              .read<MdiInsertController>()
                                              .setMessage('');

                                          if (mdiData.visitNo != null) {
                                            await model
                                                .getSelectDataByVN(
                                                    mdiData.visitNo!,
                                                    provider.organization
                                                        .organizationId!)
                                                .then((value) {
                                              if (model.data.visitNo != null) {
                                                mdiData = model.data;
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessageLastUpdate(
                                                        DateTime.now());
                                              } else {
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessage(
                                                        'waiting data VN: ${mdiData.visitNo}');
                                              }
                                            });
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                // Padding(
                                //     padding:
                                //         const EdgeInsets.fromLTRB(10, 6, 0, 6),
                                //     child: TextButton.icon(
                                //       label: const Text('All'),
                                //       icon: const Icon(Icons.clear, size: 20),
                                //       style: TextButton.styleFrom(
                                //           backgroundColor: EnvisionColor
                                //               .colorBlue
                                //               .withOpacity( 0.2),
                                //           padding: const EdgeInsets.fromLTRB(
                                //               20, 10, 20, 10),
                                //           shape: RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(10))),
                                //       onPressed: () {
                                //         mdiData = MdiDataViewModel();
                                //         setState(() {});
                                //       },
                                //     )),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    maxWidth: (inputWidth * 2),
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Patient Name',
                                    value: mdiData.patientName,
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 14,
                                    headerWidth: headerInputWidth,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Gender',
                                    value: mdiData.patientGenderText,
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 44,
                                    headerWidth: headerInputWidth,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'DOB',
                                    value: mdiData.patientDob != null
                                        ? DateFormat(EnvisionFormat
                                                .displayFormattedDate)
                                            .format(mdiData.patientDob!)
                                        : '',
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 44,
                                    headerWidth: headerInputWidth,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Age',
                                    value: mdiData.patientAgeText,
                                    valueChanged: (value) {}),
                              ],
                            ),
                          ),
                          ContainerWidget(
                            alignment: Alignment.topLeft,
                            title: 'Virtal sign',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  // alignment: WrapAlignment.start,
                                  children: [
                                    InputEntryInlineFieldWidget(
                                      headerWidth: headerInputWidth,
                                      isEnabled: canEdit,
                                      inputType: 'double',
                                      borderColor: mdiData.patientWeight == null
                                          ? Colors.blue
                                          : EnvisionColor.borderColor,
                                      maxWidth: inputWidth,
                                      isPassword: false,
                                      title: 'Weight',
                                      value:
                                          doubleToString(mdiData.patientWeight),
                                      valueChanged: (value) {
                                        if (value[value.length - 1] != '.') {
                                          mdiData.patientWeight =
                                              stringToDouble(value);

                                          if (mdiData.patientWeight != null &&
                                              mdiData.patientHeight != null) {
                                            var h =
                                                mdiData.patientHeight! / 100;
                                            var bmi = mdiData.patientWeight! /
                                                (h * h);
                                            mdiData.patientBmi = double.parse(
                                                bmi.toStringAsFixed(2));
                                          }

                                          setState(() {});
                                        } else {
                                          mdiData.patientWeight =
                                              stringToDouble(value);
                                        }
                                      },
                                      onSubmitted: (value) {
                                        mdiData.patientWeight =
                                            stringToDouble(value);
                                        var h = mdiData.patientHeight! / 100;
                                        var bmi =
                                            mdiData.patientWeight! / (h * h);
                                        mdiData.patientBmi = double.parse(
                                            bmi.toStringAsFixed(2));
                                        setState(() {});
                                      },
                                    ),
                                    InputEntryInlineFieldWidget(
                                        headerWidth: headerInputWidth,
                                        isEnabled: canEdit,
                                        inputType: 'double',
                                        borderColor:
                                            mdiData.patientHeight == null
                                                ? Colors.blue
                                                : EnvisionColor.borderColor,
                                        maxWidth: inputWidth,
                                        isPassword: false,
                                        title: 'Height',
                                        value: doubleToString(
                                            mdiData.patientHeight),
                                        valueChanged: (value) {
                                          if (value[value.length - 1] != '.') {
                                            mdiData.patientHeight =
                                                stringToDouble(value);

                                            if (mdiData.patientWeight != null &&
                                                mdiData.patientHeight != null) {
                                              var h =
                                                  mdiData.patientHeight! / 100;
                                              var bmi = mdiData.patientWeight! /
                                                  (h * h);
                                              mdiData.patientBmi = double.parse(
                                                  bmi.toStringAsFixed(2));
                                            }

                                            setState(() {});
                                          } else {
                                            mdiData.patientHeight =
                                                stringToDouble(value);
                                          }
                                        },
                                        onSubmitted: (value) {
                                          mdiData.patientHeight =
                                              stringToDouble(value);
                                          var h = mdiData.patientHeight! / 100;
                                          var bmi =
                                              mdiData.patientWeight! / (h * h);
                                          mdiData.patientBmi = double.parse(
                                              bmi.toStringAsFixed(2));
                                          setState(() {});
                                        }),
                                    SizedBox(
                                      width: inputWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputEntryInlineFieldWidget(
                                              headerWidth: headerInputWidth,
                                              inputType: 'double',
                                              borderColor: mdiData.patientBmi ==
                                                      null
                                                  ? Colors.blue
                                                  : EnvisionColor.borderColor,
                                              maxWidth: inputWidth,
                                              isEnabled: false,
                                              isPassword: false,
                                              title: 'BMI',
                                              value: doubleToString(
                                                  mdiData.patientBmi),
                                              valueChanged: (value) {
                                                mdiData.patientBmi =
                                                    stringToDouble(value);
                                              }),
                                        ],
                                      ),
                                    ),
                                    InputEntryInlineFieldWidget(
                                        headerWidth: headerInputWidth,
                                        isEnabled: canEdit,
                                        inputType: 'number',
                                        borderColor: Colors.yellow[700]!,
                                        maxWidth: inputWidth,
                                        isPassword: false,
                                        // unit: 'bpm',
                                        title: 'Pulse',
                                        value: intToString(mdiData.pulseRate),
                                        valueChanged: (value) {
                                          mdiData.pulseRate =
                                              stringToInt(value);
                                        }),
                                    SizedBox(
                                      width: inputWidth * 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: headerInputWidth,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 3, 0),
                                                  child: Text(
                                                    'BP',
                                                    style: EnvisionFormat
                                                        .normalText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (inputWidth * 2) -
                                                headerInputWidth,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InputNumberWidget(
                                                  isEnabled: canEdit,
                                                  maxWidth: inputWidth * 0.25,
                                                  borderColor:
                                                      Colors.yellow[700]!,
                                                  title: '',
                                                  value: intToString(mdiData
                                                      .bloodPressureSystolic),
                                                  valueChanged: (value) {
                                                    mdiData.bloodPressureSystolic =
                                                        stringToInt(value);
                                                    if (mdiData.bloodPressureDiastolic !=
                                                            null &&
                                                        mdiData.bloodPressureSystolic !=
                                                            null) {
                                                      mdiData.bloodPressureMean =
                                                          meanArterialPressure(
                                                              mdiData
                                                                  .bloodPressureDiastolic!,
                                                              mdiData
                                                                  .bloodPressureSystolic!);
                                                      setState(() {});
                                                    }
                                                  },
                                                ),
                                                const Text(
                                                  '/',
                                                  style:
                                                      EnvisionFormat.normalText,
                                                ),
                                                InputNumberWidget(
                                                  isEnabled: canEdit,
                                                  maxWidth: inputWidth * 0.25,
                                                  borderColor:
                                                      Colors.yellow[700]!,
                                                  title: '',
                                                  value: intToString(mdiData
                                                      .bloodPressureDiastolic),
                                                  valueChanged: (value) {
                                                    mdiData.bloodPressureDiastolic =
                                                        stringToInt(value);
                                                    if (mdiData.bloodPressureDiastolic !=
                                                            null &&
                                                        mdiData.bloodPressureSystolic !=
                                                            null) {
                                                      mdiData.bloodPressureMean =
                                                          meanArterialPressure(
                                                              mdiData
                                                                  .bloodPressureDiastolic!,
                                                              mdiData
                                                                  .bloodPressureSystolic!);
                                                      setState(() {});
                                                    }
                                                  },
                                                ),
                                                const Text(
                                                  '(',
                                                  style:
                                                      EnvisionFormat.normalText,
                                                ),
                                                InputNumberWidget(
                                                  isEnabled: false,
                                                  borderColor:
                                                      Colors.yellow[700]!,
                                                  maxWidth: inputWidth * 0.25,
                                                  title: '',
                                                  value: intToString(mdiData
                                                      .bloodPressureMean),
                                                  valueChanged: (value) {
                                                    mdiData.bloodPressureMean =
                                                        int.parse(value);
                                                  },
                                                ),
                                                const Text(
                                                  ')',
                                                  style:
                                                      EnvisionFormat.normalText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //     padding: const EdgeInsets.fromLTRB(
                                    //         20, 6, 0, 6),
                                    //     child: TextButton.icon(
                                    //       label: const Text('Virtal sign'),
                                    //       icon:
                                    //           const Icon(Icons.clear, size: 20),
                                    //       style: TextButton.styleFrom(
                                    //           backgroundColor: EnvisionColor
                                    //               .colorBlue
                                    //               .withOpacity( 0.2),
                                    //           padding:
                                    //               const EdgeInsets.fromLTRB(
                                    //                   5, 10, 5, 10),
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       10))),
                                    //       onPressed: () {
                                    //         mdiData.bloodPressure = null;
                                    //         mdiData.pulseRate = null;
                                    //         mdiData.bloodPressureDiastolic =
                                    //             null;
                                    //         mdiData.bloodPressureMean = null;
                                    //         mdiData.bloodPressureSystolic =
                                    //             null;
                                    //         mdiData.patientHeight = null;
                                    //         mdiData.patientWeight = null;
                                    //         mdiData.patientBmi = null;
                                    //         setState(() {});
                                    //       },
                                    //     ))
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Refresh every: ${context.watch<MdiInsertController>().dataFrequency} sec.',
                                //       style: const TextStyle(fontSize: 10),
                                //       // style: EnvisionFormat.normalText,
                                //     ),
                                //     Row(
                                //       children: [
                                //         Text(
                                //           context
                                //               .watch<MdiInsertController>()
                                //               .messageLastUpdate,
                                //           style: const TextStyle(fontSize: 10),
                                //           // style: EnvisionFormat.normalText,
                                //         ),
                                //         IconButton(
                                //           padding: EdgeInsets.zero,
                                //           constraints: const BoxConstraints(),
                                //           icon: const Icon(Icons.refresh),
                                //           onPressed: () async {
                                //             _refresh();
                                //           },
                                //         ),
                                //         const SizedBox(width: 15),
                                //         Text(context
                                //                 .watch<MdiInsertController>()
                                //                 .message ??
                                //             ''),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Wrap(
                              children: [
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    borderColor: mdiData.spO2 == null
                                        ? Colors.blue
                                        : EnvisionColor.borderColor,
                                    inputType: 'double',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'SpO2',
                                    value: doubleToString(mdiData.spO2),
                                    valueChanged: (value) {
                                      mdiData.spO2 = stringToDouble(value);
                                      setState(() {});
                                    }),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    inputType: 'double',
                                    borderColor: mdiData.temperature == null
                                        ? Colors.blue
                                        : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'Temp',
                                    value: doubleToString(mdiData.temperature),
                                    valueChanged: (value) {
                                      mdiData.temperature =
                                          stringToDouble(value);
                                    }),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    inputType: 'number',
                                    borderColor: mdiData.painScale == null
                                        ? Colors.blue
                                        : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    // unit: '%',
                                    title: 'Pain Scale',
                                    value: intToString(mdiData.painScale),
                                    valueChanged: (value) {
                                      mdiData.painScale = stringToInt(value);
                                      setState(() {});
                                    }),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    inputType: 'double',
                                    borderColor: mdiData.respirationRate == null
                                        ? Colors.blue
                                        : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'Respiration',
                                    value:
                                        doubleToString(mdiData.respirationRate),
                                    valueChanged: (value) {
                                      mdiData.respirationRate =
                                          stringToDouble(value);
                                      setState(() {});
                                    }),
                                SizedBox(
                                  width: inputWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: headerInputWidth,
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(3, 0, 3, 0),
                                            child: Text('Smoking Status',
                                                style:
                                                    EnvisionFormat.normalText,
                                                softWrap: true),
                                          ),
                                        ),
                                      ),
                                      DropdownListWidget(
                                        isEnabled: canEdit,
                                        maxWidth: inputWidth - 137,
                                        defaultText: '', //'Smoking Status',
                                        selectedItem: selectSmokingStatus,
                                        dropdownMenuItems: smokeStatusList
                                            .map((GblGeneralModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              '${items.generalUid!}: ${items.generalName!}',
                                              style: EnvisionFormat.normalText,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (items) {
                                          mdiData.smokingStatus =
                                              items.generalUid;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    inputType: 'number',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'HSI (Smoking)',
                                    value: intToString(mdiData.smokingHsi),
                                    valueChanged: (value) {
                                      mdiData.smokingHsi = stringToInt(value);
                                    }),
                                SizedBox(
                                  width: inputWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: headerInputWidth,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 3, 0),
                                              child: Text(
                                                'Patient Type',
                                                style:
                                                    EnvisionFormat.normalText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownListWidget(
                                        isEnabled: canEdit,
                                        maxWidth: inputWidth - 137,
                                        defaultText: '', //'Pat Type',
                                        selectedItem: context
                                            .watch<MdiInsertController>()
                                            .patTypeSelected,
                                        dropdownMenuItems: context
                                            .watch<MdiInsertController>()
                                            .patTypeList
                                            .map((GblGeneralModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items.generalName!,
                                              style: EnvisionFormat.normalText,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (patType) {
                                          context
                                              .read<MdiInsertController>()
                                              .setSelectPatType(patType);
                                          mdiData.patientType =
                                              patType.generalUid;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: inputWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: headerInputWidth,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 3, 0),
                                              child: Text(
                                                'Fall Risk Type',
                                                style:
                                                    EnvisionFormat.normalText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownListWidget(
                                        isEnabled: canEdit,
                                        maxWidth: inputWidth - 137,
                                        defaultText: '', //'Pat Type',
                                        selectedItem: selectFallRiskType,
                                        dropdownMenuItems: fallRiskTypeList
                                            .map((GblGeneralModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items.generalName!,
                                              style: EnvisionFormat.normalText,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (fallRiskType) {
                                          selectFallRiskType = fallRiskType;
                                          mdiData.fallRiskType =
                                              fallRiskType.generalId;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                InputEntryInlineFieldWidget(
                                    headerWidth: headerInputWidth,
                                    isEnabled: canEdit,
                                    inputType: 'number',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    // unit: '%',
                                    title: 'CV Risk Score',
                                    value: intToString(mdiData.cvRiskScore),
                                    valueChanged: (value) {
                                      mdiData.cvRiskScore = stringToInt(value);
                                    }),
                                // InputEntryInlineFieldWidget(
                                //     inputType: 'number',
                                //     maxWidth: inputWidth,
                                //     isPassword: false,
                                //     // unit: '%',
                                //     title: 'NEWs Score',
                                //     value: intToString(mdiData.newsScore),
                                //     valueChanged: (value) {
                                //       mdiData.newsScore = stringToInt(value);
                                //     }),
                                SizedBox(
                                  width: inputWidth * 2,
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 83,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              'GCS',
                                              style: EnvisionFormat.normalText,
                                            ), //Glasgow Coma Scale
                                            SizedBox(
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: inputWidth * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 5, 0),
                                              child: Text(
                                                'E',
                                                style:
                                                    EnvisionFormat.normalText,
                                              ),
                                            ),
                                            DropdownListWidget(
                                              isEnabled: canEdit,
                                              maxWidth: (inputWidth * 0.5) - 34,
                                              defaultText:
                                                  '', // 'select Coma E Score',
                                              selectedItem: selectComaEScore,
                                              dropdownMenuItems: comaEScore
                                                  .map((GblGeneralModel items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    child: Text(
                                                      '${items.generalUid!}: ${items.generalName!}',
                                                      style: EnvisionFormat
                                                          .normalText,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (items) {
                                                mdiData.comaEScore =
                                                    int.parse(items.generalUid);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: inputWidth * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 5, 0),
                                              child: Text(
                                                'V',
                                                style:
                                                    EnvisionFormat.normalText,
                                              ),
                                            ),
                                            DropdownListWidget(
                                              isEnabled: canEdit,
                                              maxWidth: (inputWidth * 0.5) - 34,
                                              defaultText:
                                                  '', //  'select Coma V Score',
                                              selectedItem: selectComaVScore,
                                              dropdownMenuItems: comaVScore
                                                  .map((GblGeneralModel items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    child: Text(
                                                      '${items.generalUid!}: ${items.generalName!}',
                                                      style: EnvisionFormat
                                                          .normalText,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (items) {
                                                mdiData.comaVScore =
                                                    int.parse(items.generalUid);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: inputWidth * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 3, 0),
                                              child: Text(
                                                'M',
                                                style:
                                                    EnvisionFormat.normalText,
                                              ),
                                            ),
                                            DropdownListWidget(
                                              isEnabled: canEdit,
                                              maxWidth: (inputWidth * 0.5) - 36,
                                              defaultText:
                                                  '', // 'select Coma M Score',
                                              selectedItem: selectComaMScore,
                                              dropdownMenuItems: comaMScore
                                                  .map((GblGeneralModel items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    child: Text(
                                                      '${items.generalUid!}: ${items.generalName!}',
                                                      style: EnvisionFormat
                                                          .normalText,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (items) {
                                                mdiData.comaMScore =
                                                    int.parse(items.generalUid);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // InputEntryInlineFieldWidget(
                                //   maxLine: 3,
                                //   borderColor: comment == ''
                                //       ? Colors.blue
                                //       : EnvisionColor.borderColor,
                                //   maxWidth: inputWidth *
                                //       ((width / inputWidth).round() - 2),
                                //   isPassword: false,
                                //   title: 'Remark',
                                //   value: comment,
                                //   valueChanged: (value) {
                                //     comment = value;
                                //   },
                                // ),
                                Row(
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 110,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(3, 0, 3, 0),
                                          child: Text('Remark',
                                              style: EnvisionFormat.normalText,
                                              softWrap: true),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width - inputWidth,
                                      margin: const EdgeInsets.fromLTRB(
                                          EnvisionSize.inputPadding,
                                          EnvisionSize.inputPadding,
                                          0,
                                          0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            EnvisionSize.borderRadius),
                                        // color:
                                        //     _remarkController.characterCount > 0
                                        //         ? Colors.white
                                        //         : Colors.blue.withOpacity( 0.1),
                                      ),
                                      child: TxtEntryfieldWidget(
                                        title: 'Description',
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                5, 15, 2, 15),
                                        radius: 5,
                                        borderMode:
                                            BorderStyleMode.defaultEntryField,
                                        maxWidth: width - inputWidth,
                                        // readOnly: !jOrderData.isNotEmpty,
                                        // isEnabled: jOrderData.isNotEmpty,
                                        maxLine: 3,
                                        value: _strReason,
                                        valueChanged: (value) {
                                          _strReason = value;
                                        },
                                      ),
                                      // child: HtmlEditor(
                                      //   controller: _remarkController,
                                      //   htmlEditorOptions:
                                      //       const HtmlEditorOptions(
                                      //     shouldEnsureVisible: true,
                                      //     disabled: true,
                                      //     spellCheck: true,
                                      //     autoAdjustHeight: true,
                                      //     adjustHeightForKeyboard: false,
                                      //     hint: '',
                                      //   ),
                                      //   htmlToolbarOptions:
                                      //       const HtmlToolbarOptions(
                                      //     dropdownFocusColor:
                                      //         EnvisionColor.borderColor,
                                      //     dropdownBoxDecoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(8.0)),
                                      //     ),
                                      //     dropdownElevation: 30,
                                      //     initiallyExpanded: false,
                                      //     toolbarPosition:
                                      //         ToolbarPosition.aboveEditor,
                                      //     toolbarType: ToolbarType.nativeGrid,
                                      //     defaultToolbarButtons: [
                                      //       ListButtons(
                                      //         ul: false,
                                      //         ol: false,
                                      //         listStyles: false,
                                      //       ),
                                      //       InsertButtons(
                                      //         link: false,
                                      //         picture: false,
                                      //         audio: false,
                                      //         video: false,
                                      //         otherFile: false,
                                      //         table: false,
                                      //         hr: false,
                                      //       ),
                                      //       ParagraphButtons(
                                      //         alignLeft: false,
                                      //         alignCenter: false,
                                      //         alignRight: false,
                                      //         alignJustify: false,
                                      //         increaseIndent: false,
                                      //         decreaseIndent: false,
                                      //         textDirection: false,
                                      //         lineHeight: false,
                                      //         caseConverter: false,
                                      //       ),
                                      //       FontButtons(
                                      //         clearAll: false,
                                      //         subscript: false,
                                      //         superscript: false,
                                      //         strikethrough: false,
                                      //         bold: false,
                                      //         italic: false,
                                      //         underline: false,
                                      //       ),
                                      //       OtherButtons(
                                      //         fullscreen: false,
                                      //         codeview: false,
                                      //         undo: false,
                                      //         redo: false,
                                      //         help: false,
                                      //         copy: false,
                                      //         paste: false,
                                      //       ),
                                      //       ListButtons(listStyles: false),
                                      //       InsertButtons(
                                      //         link: false,
                                      //         audio: false,
                                      //         video: false,
                                      //         otherFile: false,
                                      //         hr: false,
                                      //         picture: false,
                                      //         table: false,
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   otherOptions:
                                      //       const OtherOptions(height: 100),
                                      // ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   // mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     const SizedBox(
                                //       width: 110,
                                //       child: Align(
                                //         alignment: Alignment.centerRight,
                                //         child: Padding(
                                //           padding:
                                //               EdgeInsets.fromLTRB(3, 0, 3, 0),
                                //           child: Text('Remark',
                                //               style: EnvisionFormat.normalText,
                                //               softWrap: true),
                                //         ),
                                //       ),
                                //     ),
                                //     // Text('Remark',
                                //     //     style: EnvisionFormat.normalText),
                                //     SizedBox(
                                //       width: width - inputWidth,
                                //       child: TextField(
                                //           readOnly: !canEdit,
                                //           maxLines: 3,
                                //           controller: _remarkController,
                                //           decoration: InputDecoration(
                                //             isDense: true,
                                //             contentPadding:
                                //                 const EdgeInsetsDirectional
                                //                         .only(
                                //                     top: 10,
                                //                     bottom: 10,
                                //                     start: 5.0,
                                //                     end: 5.0),
                                //             filled: true,
                                //             fillColor: _remarkController.text
                                //                     .trim()
                                //                     .isEmpty
                                //                 ? Colors.blue.withOpacity( 0.1)
                                //                 : Colors.white,
                                //             // labelText: title,
                                //             enabledBorder: OutlineInputBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         EnvisionSize
                                //                             .borderRadius),
                                //                 borderSide: BorderSide(
                                //                     color: _remarkController
                                //                             .text
                                //                             .trim()
                                //                             .isEmpty
                                //                         ? Colors.blue
                                //                         : EnvisionColor
                                //                             .borderColor,
                                //                     width: 1.0,
                                //                     style: BorderStyle.solid)),
                                //             disabledBorder: OutlineInputBorder(
                                //                 borderRadius: BorderRadius
                                //                     .circular(EnvisionSize
                                //                         .borderRadius),
                                //                 borderSide: const BorderSide(
                                //                     color: EnvisionColor
                                //                         .disabledColor,
                                //                     width: 1.0,
                                //                     style: BorderStyle.solid)),
                                //             focusedBorder: OutlineInputBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         EnvisionSize
                                //                             .borderRadius),
                                //                 borderSide: const BorderSide(
                                //                     color: EnvisionColor
                                //                         .focusColor,
                                //                     width: 1.0,
                                //                     style: BorderStyle.solid)),
                                //             hintText: 'Remark',
                                //             hintStyle: const TextStyle(
                                //               color: Color.fromARGB(
                                //                   255, 131, 131, 131),
                                //             ),
                                //           )),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        SizedBox(
                          height: 40,
                          width: 150,
                          // child:
                          // TextButton(
                          //     onPressed: null,
                          //     // () {
                          //     //   onSaveConfirmData();
                          //     // },
                          //     style: ButtonStyle(
                          //         backgroundColor: WidgetStateProperty.all(
                          //             EnvisionColor.colorGreen),
                          //         shape: WidgetStateProperty.all<
                          //                 RoundedRectangleBorder>(
                          //             RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(18.0),
                          //           // side: BorderSide(color: Colors.red)
                          //         ))),
                          //     child: const Text(
                          //       'Save & Confirm',
                          //       style: TextStyle(
                          //         color: EnvisionColor.colorGrey,
                          //       ),
                          //     )),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String intToString(int? data) {
    return data == null ? '' : data.toString();
  }

  String doubleToString(double? data) {
    return data == null ? '' : data.toString();
  }

  double? stringToDouble(String? value) {
    return value == null || value == '' ? null : double.parse(value);
  }

  int? stringToInt(String? value) {
    return value == null || value == '' ? null : int.parse(value);
  }

  int meanArterialPressure(int d, int s) {
    var m = d + (s - d) / 3;
    return m.round();
  }

  void btnSearchPatientClick(BuildContext context, MdiViewModel model) {
    showModalBottomSheet<MdiDataViewModel>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: (MediaQuery.of(context).size.height / 1.2),
          child: PopupSearchPatient(modalityId: provider.modality.modalityId
              // orgId: org.organizationId, locationId: location.locationId
              ),
        );
      },
    ).then((value) {
      if (value != null) {
        mdiData = value;
        context
            .read<MdiInsertController>()
            .setMessageLastUpdate(DateTime.now());
        setState(() {});
      }
    });
  }

  // onSaveData() {
  //   String warning = checkData();
  //   if (warning == '') {
  //     _showConfirmDialog(context, 'Save Data ?', '', () async {
  //       Navigator.pop(context, 'OK');
  //       mdiData.isConfirmed = 0;
  //       await model.setEditMdiData(mdiData, 1).then((value) {
  //         var header = '';
  //         var datail = '${value.acknowledgementCode} : ${value.textMessage}';
  //         if (value.acknowledgementCode == 'AA') {
  //           header = 'Success saved data HN: ${mdiData.hn}';
  //           setState(() {
  //             mdiData = MdiDataViewModel();
  //             message = header;
  //             comment = '';
  //           });
  //         } else {
  //           header = 'Fail to save data.';
  //           _showAlertDialog(context, header, datail);
  //         }
  //         // Navigator.pop(context, 'OK');
  //       });
  //     });
  //   } else {
  //     _showAlertDialog(context, 'Please fill data. ', '');
  //   }
  // }

  // onSaveConfirmData() {
  //   String warning = checkData();
  //   if (warning == '') {
  //     _showConfirmDialog(context, 'Save & Confirm Data ?', '', () async {
  //       Navigator.pop(context, 'OK');
  //       //test
  //       mdiData.isConfirmed = 1;
  //       mdiData.confirmedByUid = provider.confirmedByUid;
  //       mdiData.comment = _remarkController.text.trim();
  //       await model.setEditMdiData(mdiData, 1).then((value) {
  //         context.read<MdiInsertController>().toggleRefresh();
  //         var header = '';
  //         var datail = '${value.acknowledgementCode} : ${value.textMessage}';
  //         if (value.acknowledgementCode == 'AA') {
  //           header = 'Success confirm data HN: ${mdiData.hn}';
  //           setState(() {
  //             _remarkController.text = '';
  //             mdiData = MdiDataViewModel();
  //             _focusNode.requestFocus();
  //           });
  //           context.read<MdiInsertController>().setMessage(header);
  //         } else {
  //           header = 'Fail to Confirm data.';
  //           _showAlertDialog(context, header, datail);
  //           setState(() {
  //             _focusNode.requestFocus();
  //           });
  //         }
  //         // Navigator.pop(context, 'OK');
  //       });
  //     });
  //     setState(() {
  //       _focusNode.requestFocus();
  //     });
  //     context.read<MdiInsertController>().toggleRefresh();
  //   } else {
  //     _focusEnterNode.requestFocus();
  //     _showAlertDialog(context, 'Please fill data. ', warning);
  //   }
  // }

  _showAlertDialog(context, String header, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          header,
          style: EnvisionFormat.normalText,
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            focusNode: _focusEnterNode,
            onPressed: () => {Navigator.pop(context, 'OK')},
            child: const Text(
              'OK',
              style: EnvisionFormat.normalText,
            ),
          ),
        ],
      ),
    );
  }

  _showConfirmDialog(
      context, String header, String content, Function()? onConfirm) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          header,
          style: EnvisionFormat.normalText,
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => {Navigator.pop(context, 'Cancel')},
            child: const Text(
              'Cancel',
              style: EnvisionFormat.normalText,
            ),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text(
              'OK',
              style: EnvisionFormat.normalText,
            ),
          ),
        ],
      ),
    );
  }

  // String checkData() {
  //   String warning = '';

  //   if (provider.confirmedByUid == '') {
  //     return warning += 'Please login again \n';
  //   }

  //   if (mdiData.hn == '' || mdiData.hn == null) {
  //     return warning += 'Please enter HN \n';
  //   }
  //   // if (mdiData.visitNo == null ||
  //   //     mdiData.patientVisitId == null ||
  //   //     mdiData.dataId == null) {
  //   //   return warning += 'HN dosen\'t have visit today\n';
  //   // }

  //   if (mdiData.spO2 == null) {
  //     warning += '• SpO2\n';
  //   }
  //   if (mdiData.temperature == null) {
  //     warning += '• Temperature\n';
  //   }
  //   // if (mdiData.pulseRate == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.bloodPressureSystolic == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.bloodPressureDiastolic == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.bloodPressureMean == null) {
  //   //   return false;
  //   // }
  //   if (mdiData.respirationRate == null) {
  //     warning += '• Respiration Rate\n';
  //   }
  //   if (mdiData.painScale == null) {
  //     warning += '• Pain scale\n';
  //   }

  //   // if (mdiData.confirmedByUid == null) {
  //   //   return false;
  //   // }
  //   if (mdiData.patientWeight == null) {
  //     warning += '• Patient Weight\n';
  //   }
  //   if (mdiData.patientHeight == null) {
  //     warning += '• Patient Height\n';
  //   }
  //   if (mdiData.patientBmi == null) {
  //     warning += '• Patient BMI\n';
  //   }
  //   // if (mdiData.patientType == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.comaEScore == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.comaVScore == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.comaMScore == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.smokingStatus == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.cvRiskScore == null) {
  //   //   return false;
  //   // }
  //   // if (mdiData.mewsScore == null) {
  //   //   return false;
  //   // }

  //   if (_remarkController.text.trim().isEmpty) {
  //     warning += '• Remark\n';
  //   }
  //   return warning;
  // }

  Future _searchHN(String hn) async {
    context.read<MdiInsertController>().toggleLoadingHn();
    context.read<MdiInsertController>().setMessage('');
    if (hn != '') {
      mdiData = MdiDataViewModel(hn: hn);
      await model
          .getSelectDataByHn(hn, provider.organization.organizationId!)
          .then((value) {
        if (model.data.hn != null) {
          mdiData = model.data;
          context
              .read<MdiInsertController>()
              .setMessageLastUpdate(DateTime.now());
        } else {
          _focusEnterNode.requestFocus();
          _showAlertDialog(
              context, 'No Patient', 'there is no patient register in this HN');
        }
      });
    }
    context.read<MdiInsertController>().toggleLoadingHn();

    setState(() {});
  }

  // Future _refresh() async {
  //   if (mdiData.visitNo != null) {
  //     await model
  //         .getSelectDataByVN(
  //             mdiData.visitNo!, provider.organization.organizationId!)
  //         .then((value) {
  //       if (model.data.visitNo != null) {
  //         mdiData = MdiDataViewModel.fetchData(mdiData, model.data);
  //       }
  //     });
  //   } else if (mdiData.hn != '' && mdiData.hn != null) {
  //     if (mdiData.dataId != null) {
  //       await model.getSelectDataById(mdiData.dataId!).then((value) {
  //         if (model.data.lastModifiedOn!.compareTo(mdiData.lastModifiedOn!) <
  //             0) {
  //           mdiData = MdiDataViewModel.fetchData(mdiData, model.data);
  //         }
  //       });
  //     } else {
  //       await model.getSelectDataNonConfirmByHn(mdiData.hn!).then((value) {
  //         mdiData = MdiDataViewModel.fetchDataByHn(mdiData, model.data);
  //       });
  //     }
  //   }
  //   context.read<MdiInsertController>().setMessageLastUpdate(DateTime.now());
  //   mdiData.confirmedByUid = provider.confirmedByUid;
  //   setState(() {});
  // }

  String convertPlainToHtml(String source) {
    String result = "";
    if (source.isNotEmpty) {
      result = source;
      result = result.replaceAll(" ", "&nbsp;");
      result = result.replaceAll("\r\n", "<br>");
      result = result.replaceAll("\n", "<br>");
      result = result.replaceAll("\r", "<br>");
      // result = result.replaceAll("-", "<br>");
    }
    return result;
  }
}
