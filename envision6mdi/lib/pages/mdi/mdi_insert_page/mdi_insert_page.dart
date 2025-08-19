// ignore_for_file: use_build_context_synchronously
import 'package:envision6mdi/controllers/mdi_insert_controller.dart';
import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/gbl_general_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/pages/login/login_operator_page.dart';
import 'package:envision6mdi/pages/mdi/mdi_insert_page/popup_search_patient.dart';
import 'package:envision6mdi/widgets/container_widget.dart';
import 'package:envision6mdi/widgets/dropdown_search_widget.dart';
import 'package:envision6mdi/widgets/input_entry_inline_field.dart';
import 'package:envision6mdi/widgets/input_number_widget.dart';
import 'package:envision6mdi/widgets/txt_entryfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MdiInsertPage extends StatefulWidget {
  const MdiInsertPage({
    super.key,
  });

  @override
  State<MdiInsertPage> createState() => _MdiInsertPageState();
}

class _MdiInsertPageState extends State<MdiInsertPage> {
  // late MdiInsertController provider;
  late double inputWidth = 300;
  // late MdiDataViewModel mdiData = MdiDataViewModel();
  // late MdiViewModel model = MdiViewModel();
  String result = '';

  late String hn = '';
  // late String comment = '';
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusEnterNode = FocusNode();
  final TextEditingController _remarkController = TextEditingController();

  ValueNotifier<TextEditingValue> textNotifier =
      ValueNotifier(TextEditingValue());

  //list
  // late List<GblGeneralModel> smokeStatusList = [];
  // late List<GblGeneralModel> patTypeList = [];
  // late List<GblGeneralModel> comaEScore = [];
  // late List<GblGeneralModel> comaVScore = [];
  // late List<GblGeneralModel> comaMScore = [];
  // late List<GblGeneralModel> fallRiskTypeList = [];
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusEnterNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<MdiInsertController>().toggleLoading();
      await context.read<MdiInsertController>().setDataToInsertForm();
      await context.read<MdiViewModel>().prepareVisitData(
          context.read<MdiInsertController>().modality.modalityUid);
      context.read<MdiInsertController>().setDataFrequency();
      context.read<MdiInsertController>().toggleLoading();
    });
  }

  @override
  void dispose() {
    _remarkController.dispose(); // Dispose controller to free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var insertProvider =
        Provider.of<MdiInsertController>(context, listen: false);
    inputWidth = MediaQuery.of(context).size.width > 1370 ? 330 : 225;
    // return ViewModelBuilder<MdiViewModel>.reactive(
    //     viewModelBuilder: () => MdiViewModel(),
    //     onViewModelReady: (model) =>
    //         model.prepareVisitData(provider.modality.modalityUid).then(
    //           (value) {
    //             smokeStatusList = model.smokeStatusList;
    //             comaEScore = model.comaEScore;
    //             comaVScore = model.comaVScore;
    //             comaMScore = model.comaMScore;
    //             fallRiskTypeList = model.fallRiskTypeList;
    //             setState(() {});
    //             print('refresh');
    //             context.read<MdiInsertController>().setDataFrequency();
    //             context.read<MdiInsertController>().toggleLoading();
    //           },
    //         ),
    //     builder: (context, model, child) {
    return Scaffold(
        body: StreamBuilder(
      stream: Stream.periodic(Duration(
              seconds: context.watch<MdiInsertController>().dataFrequency))
          .asyncMap(
        (i) async {
          if (insertProvider.mdiData.hn != null ||
              insertProvider.mdiData.visitNo != null) {
            if (isRefresh()) {
              _refresh();
            }
          }
        },
      ),
      builder: (context, snapshot) {
        return ColoredBox(
          color: Colors.white,
          child: context.watch<MdiInsertController>().isLoading
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Envision MDI',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6,
                            wordSpacing: 6,
                            fontSize: 30)),
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 100,
                    ),
                    const Text('v 2.304',
                        style: TextStyle(
                          color: Colors.blue,
                          letterSpacing: 4,
                        )),
                  ],
                ))
              : insertForm(),
        );
      },
    ));
    // });
  }

  Widget insertForm() {
    var insertProvider = context.read<MdiInsertController>();
    var mdiProvider = context.read<MdiViewModel>();
    // var selectPatTypeList =
    //     patTypeList.where((e) => e.generalUid == mdiData.patientType).toList();
    // var selectPatType =
    //     selectPatTypeList.isNotEmpty ? selectPatTypeList.first : null;
    var selectComaEScoreList = mdiProvider.comaEScore
        .where(
            (e) => e.generalUid == insertProvider.mdiData.comaEScore.toString())
        .toList();
    var selectComaEScore =
        selectComaEScoreList.isNotEmpty ? selectComaEScoreList.first : null;
    var selectComaVScoreList = mdiProvider.comaVScore
        .where(
            (e) => e.generalUid == insertProvider.mdiData.comaVScore.toString())
        .toList();
    var selectComaVScore =
        selectComaVScoreList.isNotEmpty ? selectComaVScoreList.first : null;
    var selectComaMScoreList = mdiProvider.comaMScore
        .where(
            (e) => e.generalUid == insertProvider.mdiData.comaMScore.toString())
        .toList();
    var selectComaMScore =
        selectComaMScoreList.isNotEmpty ? selectComaMScoreList.first : null;
    var selectSmokingStatusList = mdiProvider.smokeStatusList
        .where((e) => e.generalUid == insertProvider.mdiData.smokingStatus)
        .toList();
    var selectSmokingStatus = selectSmokingStatusList.isNotEmpty
        ? selectSmokingStatusList.first
        : null;
    double width = MediaQuery.of(context).size.width > 1500
        ? 1500
        : MediaQuery.of(context).size.width;
    var selectFallRiskTypeList = mdiProvider.fallRiskTypeList
        .where((e) => e.generalId == insertProvider.mdiData.fallRiskType)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('images/pts_logo.jpg'),
                            width: 60),
                        Text(
                          insertProvider.organization.organizationName ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.end,
                      children: [
                        Visibility(
                          visible:
                              insertProvider.modality.modalityName != null &&
                                  insertProvider.modality.modalityName != '',
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: SizedBox(
                              height: 30,
                              child: TextButton.icon(
                                label: Text(
                                    'today ${insertProvider.modality.modalityName ?? ''} cases'),
                                icon: const Icon(Icons.search, size: 20),
                                style: TextButton.styleFrom(
                                    backgroundColor: EnvisionColor.colorBlue
                                        .withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  btnSearchPatientClick(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        InputEntryInlineFieldWidget(
                            maxWidth: inputWidth,
                            isEnabled: false,
                            isPassword: false,
                            title: 'Location',
                            value: insertProvider.mdiData.locationText,
                            valueChanged: (value) {}),
                        Container(
                          constraints: const BoxConstraints(minWidth: 150),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              const Text(
                                'USER ID: ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                insertProvider.confirmedByUid,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: SizedBox(
                            height: 30,
                            // width: 75,
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginOperatorPage(
                                            modalityUid: insertProvider
                                                .modality.modalityUid,
                                          )),
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      EnvisionColor.colorRed),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    // side: BorderSide(color: Colors.red)
                                  ))),
                              icon: const Icon(
                                Icons.logout,
                                color: EnvisionColor.colorGrey,
                              ),
                              label: const Text(
                                '',
                                style: TextStyle(
                                  color: EnvisionColor.colorGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                                    children: [
                                      Visibility(
                                        visible: context
                                            .watch<MdiInsertController>()
                                            .isLoadingHn,
                                        replacement: Container(
                                          width: 60,
                                        ),
                                        child: SizedBox(
                                          width: 60,
                                          child: LoadingAnimationWidget.inkDrop(
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      InputEntryInlineFieldWidget(
                                        headerWidth: 50,
                                        maxWidth: inputWidth - 60,
                                        isPassword: false,
                                        title: 'HN',
                                        textFocus: _focusNode,
                                        value: insertProvider.mdiData.hn,
                                        valueChanged: (value) {
                                          insertProvider.mdiData.hn = value;
                                          insertProvider.onUpdate();
                                        },
                                        onSubmitted: (value) async {
                                          _searchHN(value);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          if (insertProvider.mdiData.hn !=
                                              null) {
                                            _searchHN(
                                                insertProvider.mdiData.hn!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: inputWidth + 50,
                                  child: Row(
                                    children: [
                                      InputEntryInlineFieldWidget(
                                        headerWidth: 110 - 50,
                                        maxWidth: inputWidth - 50,
                                        isPassword: false,
                                        title: 'VN',
                                        value: insertProvider.mdiData.visitNo,
                                        valueChanged: (value) {
                                          insertProvider.mdiData.visitNo =
                                              value;
                                          insertProvider.onUpdate();
                                        },
                                        onSubmitted: (value) async {
                                          context
                                              .read<MdiInsertController>()
                                              .setMessage('');

                                          if (value != '') {
                                            insertProvider.setMdiData(
                                                MdiDataViewModel(
                                                    visitNo: value));

                                            await mdiProvider
                                                .getSelectDataByVN(
                                                    value,
                                                    insertProvider.organization
                                                        .organizationId!)
                                                .then((value) {
                                              if (mdiProvider.data.hn != null) {
                                                insertProvider.setMdiData(
                                                    mdiProvider.data);
                                                // insertProvider.mdiData =
                                                //     mdiProvider.data;
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessageLastUpdate(
                                                        DateTime.now());
                                              } else {
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessage(
                                                        'waiting data VN: ${insertProvider.mdiData.visitNo}');
                                              }
                                            });
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          context
                                              .read<MdiInsertController>()
                                              .setMessage('');

                                          if (insertProvider.mdiData.visitNo !=
                                              null) {
                                            await mdiProvider
                                                .getSelectDataByVN(
                                                    insertProvider
                                                        .mdiData.visitNo!,
                                                    insertProvider.organization
                                                        .organizationId!)
                                                .then((value) {
                                              if (mdiProvider.data.visitNo !=
                                                  null) {
                                                insertProvider.setMdiData(
                                                    mdiProvider.data);

                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessageLastUpdate(
                                                        DateTime.now());
                                              } else {
                                                context
                                                    .read<MdiInsertController>()
                                                    .setMessage(
                                                        'waiting data VN: ${insertProvider.mdiData.visitNo}');
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 6, 0, 6),
                                    child: TextButton.icon(
                                      label: const Text('All'),
                                      icon: const Icon(Icons.clear, size: 20),
                                      style: TextButton.styleFrom(
                                          backgroundColor: EnvisionColor
                                              .colorBlue
                                              .withOpacity(0.2),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        insertProvider
                                            .setMdiData(MdiDataViewModel());
                                      },
                                    )),
                                InputEntryInlineFieldWidget(
                                    maxWidth: (inputWidth * 2),
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Patient Name',
                                    value: insertProvider.mdiData.patientName,
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 54 - 10 - 30,
                                    headerWidth: 110 - 49,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Gender',
                                    value: insertProvider
                                        .mdiData.patientGenderText,
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 54 + 10,
                                    headerWidth: 110 - 54 - 10,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'DOB',
                                    value: insertProvider.mdiData.patientDob !=
                                            null
                                        ? DateFormat(EnvisionFormat
                                                .displayFormattedDate)
                                            .format(insertProvider
                                                .mdiData.patientDob!)
                                        : '',
                                    valueChanged: (value) {}),
                                InputEntryInlineFieldWidget(
                                    maxWidth: inputWidth - 54 + 10,
                                    headerWidth: 110 - 54 - 10,
                                    isEnabled: false,
                                    isPassword: false,
                                    title: 'Age',
                                    value:
                                        insertProvider.mdiData.patientAgeText,
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
                                  children: [
                                    InputEntryInlineFieldWidget(
                                      inputType: 'double',
                                      borderColor: insertProvider
                                                  .mdiData.patientWeight ==
                                              null
                                          ? Colors.blue
                                          : EnvisionColor.borderColor,
                                      maxWidth: inputWidth,
                                      isPassword: false,
                                      title: 'Weight',
                                      value: doubleToString(
                                          insertProvider.mdiData.patientWeight),
                                      valueChanged: (value) {
                                        if (value != '' &&
                                            value[value.length - 1] != '.') {
                                          insertProvider.mdiData.patientWeight =
                                              stringToDouble(value);

                                          if (insertProvider
                                                      .mdiData.patientWeight !=
                                                  null &&
                                              insertProvider
                                                      .mdiData.patientHeight !=
                                                  null) {
                                            var h = insertProvider
                                                    .mdiData.patientHeight! /
                                                100;
                                            var bmi = insertProvider
                                                    .mdiData.patientWeight! /
                                                (h * h);
                                            insertProvider.mdiData.patientBmi =
                                                double.parse(
                                                    bmi.toStringAsFixed(2));
                                          }
                                          insertProvider.onUpdate();
                                        } else {
                                          insertProvider.mdiData.patientWeight =
                                              stringToDouble(value);
                                        }
                                      },
                                      onSubmitted: (value) {
                                        insertProvider.mdiData.patientWeight =
                                            stringToDouble(value);
                                        var h = insertProvider
                                                .mdiData.patientHeight! /
                                            100;
                                        var bmi = insertProvider
                                                .mdiData.patientWeight! /
                                            (h * h);
                                        insertProvider.mdiData.patientBmi =
                                            double.parse(
                                                bmi.toStringAsFixed(2));
                                        insertProvider.onUpdate();
                                      },
                                    ),
                                    InputEntryInlineFieldWidget(
                                        inputType: 'double',
                                        borderColor: insertProvider
                                                    .mdiData.patientHeight ==
                                                null
                                            ? Colors.blue
                                            : EnvisionColor.borderColor,
                                        maxWidth: inputWidth,
                                        isPassword: false,
                                        title: 'Height',
                                        value: doubleToString(insertProvider
                                            .mdiData.patientHeight),
                                        valueChanged: (value) {
                                          if (value != '' &&
                                              value[value.length - 1] != '.') {
                                            insertProvider
                                                    .mdiData.patientHeight =
                                                stringToDouble(value);

                                            if (insertProvider.mdiData
                                                        .patientWeight !=
                                                    null &&
                                                insertProvider.mdiData
                                                        .patientHeight !=
                                                    null) {
                                              var h = insertProvider
                                                      .mdiData.patientHeight! /
                                                  100;
                                              var bmi = insertProvider
                                                      .mdiData.patientWeight! /
                                                  (h * h);
                                              insertProvider
                                                      .mdiData.patientBmi =
                                                  double.parse(
                                                      bmi.toStringAsFixed(2));
                                            }

                                            insertProvider.onUpdate();
                                          } else {
                                            insertProvider
                                                    .mdiData.patientHeight =
                                                stringToDouble(value);
                                          }
                                        },
                                        onSubmitted: (value) {
                                          insertProvider.mdiData.patientHeight =
                                              stringToDouble(value);
                                          var h = insertProvider
                                                  .mdiData.patientHeight! /
                                              100;
                                          var bmi = insertProvider
                                                  .mdiData.patientWeight! /
                                              (h * h);
                                          insertProvider.mdiData.patientBmi =
                                              double.parse(
                                                  bmi.toStringAsFixed(2));
                                          insertProvider.onUpdate();
                                        }),
                                    SizedBox(
                                      width: inputWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputEntryInlineFieldWidget(
                                              inputType: 'double',
                                              borderColor: insertProvider
                                                          .mdiData.patientBmi ==
                                                      null
                                                  ? Colors.blue
                                                  : EnvisionColor.borderColor,
                                              maxWidth: inputWidth,
                                              isEnabled: false,
                                              isPassword: false,
                                              title: 'BMI',
                                              value: doubleToString(
                                                  insertProvider
                                                      .mdiData.patientBmi),
                                              valueChanged: (value) {
                                                insertProvider
                                                        .mdiData.patientBmi =
                                                    stringToDouble(value);
                                              }),
                                        ],
                                      ),
                                    ),
                                    InputEntryInlineFieldWidget(
                                        inputType: 'number',
                                        borderColor: Colors.yellow[700]!,
                                        maxWidth: inputWidth,
                                        isPassword: false,
                                        // unit: 'bpm',
                                        title: 'Pulse',
                                        value: intToString(
                                            insertProvider.mdiData.pulseRate),
                                        valueChanged: (value) {
                                          insertProvider.mdiData.pulseRate =
                                              stringToInt(value);
                                        }),
                                    SizedBox(
                                      width: inputWidth * 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 110,
                                            child: Row(
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
                                            width: (inputWidth * 2) - 110,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InputNumberWidget(
                                                  maxWidth: inputWidth * 0.25,
                                                  borderColor:
                                                      Colors.yellow[700]!,
                                                  title: '',
                                                  value: intToString(
                                                      insertProvider.mdiData
                                                          .bloodPressureSystolic),
                                                  valueChanged: (value) {
                                                    insertProvider.mdiData
                                                            .bloodPressureSystolic =
                                                        stringToInt(value);
                                                    if (insertProvider.mdiData
                                                                .bloodPressureDiastolic !=
                                                            null &&
                                                        insertProvider.mdiData
                                                                .bloodPressureSystolic !=
                                                            null) {
                                                      insertProvider
                                                              .mdiData.bloodPressureMean =
                                                          meanArterialPressure(
                                                              insertProvider
                                                                  .mdiData
                                                                  .bloodPressureDiastolic!,
                                                              insertProvider
                                                                  .mdiData
                                                                  .bloodPressureSystolic!);
                                                      insertProvider.onUpdate();
                                                    }
                                                  },
                                                ),
                                                const Text(
                                                  '/',
                                                  style:
                                                      EnvisionFormat.normalText,
                                                ),
                                                InputNumberWidget(
                                                  maxWidth: inputWidth * 0.25,
                                                  borderColor:
                                                      Colors.yellow[700]!,
                                                  title: '',
                                                  value: intToString(insertProvider
                                                      .mdiData
                                                      .bloodPressureDiastolic),
                                                  valueChanged: (value) {
                                                    insertProvider.mdiData
                                                            .bloodPressureDiastolic =
                                                        stringToInt(value);
                                                    if (insertProvider.mdiData
                                                                .bloodPressureDiastolic !=
                                                            null &&
                                                        insertProvider.mdiData
                                                                .bloodPressureSystolic !=
                                                            null) {
                                                      insertProvider
                                                              .mdiData.bloodPressureMean =
                                                          meanArterialPressure(
                                                              insertProvider
                                                                  .mdiData
                                                                  .bloodPressureDiastolic!,
                                                              insertProvider
                                                                  .mdiData
                                                                  .bloodPressureSystolic!);
                                                      insertProvider.onUpdate();
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
                                                  value: intToString(
                                                      insertProvider.mdiData
                                                          .bloodPressureMean),
                                                  valueChanged: (value) {
                                                    insertProvider.mdiData
                                                            .bloodPressureMean =
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
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 6, 0, 6),
                                        child: TextButton.icon(
                                          label: const Text('Virtal sign'),
                                          icon:
                                              const Icon(Icons.clear, size: 20),
                                          style: TextButton.styleFrom(
                                              backgroundColor: EnvisionColor
                                                  .colorBlue
                                                  .withOpacity(0.2),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 10, 5, 10),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            insertProvider
                                                .mdiData.bloodPressure = null;
                                            insertProvider.mdiData.pulseRate =
                                                null;
                                            insertProvider.mdiData
                                                .bloodPressureDiastolic = null;
                                            insertProvider.mdiData
                                                .bloodPressureMean = null;
                                            insertProvider.mdiData
                                                .bloodPressureSystolic = null;
                                            insertProvider
                                                .mdiData.patientHeight = null;
                                            insertProvider
                                                .mdiData.patientWeight = null;
                                            insertProvider.mdiData.patientBmi =
                                                null;
                                            insertProvider.onUpdate();
                                          },
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Refresh every: ${context.watch<MdiInsertController>().dataFrequency} sec.',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          context
                                              .watch<MdiInsertController>()
                                              .messageLastUpdate,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.refresh),
                                          onPressed: () async {
                                            _refresh();
                                          },
                                        ),
                                        const SizedBox(width: 15),
                                        context
                                                        .watch<
                                                            MdiInsertController>()
                                                        .message !=
                                                    null &&
                                                context
                                                        .watch<
                                                            MdiInsertController>()
                                                        .message !=
                                                    ''
                                            ? Tooltip(
                                                message: context
                                                        .watch<
                                                            MdiInsertController>()
                                                        .message ??
                                                    '',
                                                child:
                                                    const Icon(Icons.warning))
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Wrap(
                              children: [
                                InputEntryInlineFieldWidget(
                                    borderColor:
                                        insertProvider.mdiData.spO2 == null
                                            ? Colors.blue
                                            : EnvisionColor.borderColor,
                                    inputType: 'double',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'SpO2',
                                    value: doubleToString(
                                        insertProvider.mdiData.spO2),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.spO2 =
                                          stringToDouble(value);
                                      insertProvider.onUpdate();
                                    }),
                                InputEntryInlineFieldWidget(
                                    inputType: 'double',
                                    borderColor:
                                        insertProvider.mdiData.temperature ==
                                                null
                                            ? Colors.blue
                                            : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'Temp',
                                    value: doubleToString(
                                        insertProvider.mdiData.temperature),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.temperature =
                                          stringToDouble(value);
                                    }),
                                InputEntryInlineFieldWidget(
                                    inputType: 'number',
                                    borderColor:
                                        insertProvider.mdiData.painScale == null
                                            ? Colors.blue
                                            : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    // unit: '%',
                                    title: 'Pain Scale',
                                    value: intToString(
                                        insertProvider.mdiData.painScale),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.painScale =
                                          stringToInt(value);
                                      insertProvider.onUpdate();
                                    }),
                                InputEntryInlineFieldWidget(
                                    inputType: 'double',
                                    borderColor: insertProvider
                                                .mdiData.respirationRate ==
                                            null
                                        ? Colors.blue
                                        : EnvisionColor.borderColor,
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'Respiration',
                                    value: doubleToString(
                                        insertProvider.mdiData.respirationRate),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.respirationRate =
                                          stringToDouble(value);
                                      insertProvider.onUpdate();
                                    }),
                                SizedBox(
                                  width: inputWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 110,
                                        child: Align(
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
                                        maxWidth: inputWidth - 110 - 7,
                                        defaultText: '', //'Smoking Status',
                                        selectedItem: selectSmokingStatus,
                                        dropdownMenuItems: mdiProvider
                                            .smokeStatusList
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
                                          insertProvider.mdiData.smokingStatus =
                                              items.generalUid;
                                          insertProvider.onUpdate();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                InputEntryInlineFieldWidget(
                                    inputType: 'number',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    title: 'HSI (Smoking)',
                                    value: intToString(
                                        insertProvider.mdiData.smokingHsi),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.smokingHsi =
                                          stringToInt(value);
                                    }),
                                SizedBox(
                                  width: inputWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 110,
                                        child: Row(
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
                                        maxWidth: inputWidth - 110 - 7,
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
                                          insertProvider.mdiData.patientType =
                                              patType.generalUid;
                                          insertProvider.onUpdate();
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
                                      const SizedBox(
                                        width: 110,
                                        child: Row(
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
                                        maxWidth: inputWidth - 110 - 7,
                                        defaultText: '', //'Pat Type',
                                        selectedItem: selectFallRiskType,
                                        dropdownMenuItems: mdiProvider
                                            .fallRiskTypeList
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
                                          insertProvider.mdiData.fallRiskType =
                                              fallRiskType.generalId;
                                          insertProvider.onUpdate();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                InputEntryInlineFieldWidget(
                                    inputType: 'number',
                                    maxWidth: inputWidth,
                                    isPassword: false,
                                    // unit: '%',
                                    title: 'CV Risk Score',
                                    value: intToString(
                                        insertProvider.mdiData.cvRiskScore),
                                    valueChanged: (value) {
                                      insertProvider.mdiData.cvRiskScore =
                                          stringToInt(value);
                                    }),
                                SizedBox(
                                  width: inputWidth * 2,
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 110 - 27,
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
                                              maxWidth:
                                                  inputWidth * 0.5 - 21 - 13,
                                              defaultText:
                                                  '', // 'select Coma E Score',
                                              selectedItem: selectComaEScore,
                                              dropdownMenuItems: mdiProvider
                                                  .comaEScore
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
                                                insertProvider
                                                        .mdiData.comaEScore =
                                                    int.parse(items.generalUid);

                                                insertProvider.onUpdate();
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
                                              maxWidth:
                                                  inputWidth * 0.5 - 21 - 13,
                                              defaultText:
                                                  '', //  'select Coma V Score',
                                              selectedItem: selectComaVScore,
                                              dropdownMenuItems: mdiProvider
                                                  .comaVScore
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
                                                insertProvider
                                                        .mdiData.comaVScore =
                                                    int.parse(items.generalUid);
                                                insertProvider.onUpdate();
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
                                              maxWidth:
                                                  inputWidth * 0.5 - 21 - 13,
                                              defaultText:
                                                  '', // 'select Coma M Score',
                                              selectedItem: selectComaMScore,
                                              dropdownMenuItems: mdiProvider
                                                  .comaMScore
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
                                                insertProvider
                                                        .mdiData.comaMScore =
                                                    int.parse(items.generalUid);
                                                insertProvider.onUpdate();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
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
                                    TxtEntryfieldWidget(
                                      textController: _remarkController,
                                      maxWidth: width - inputWidth,
                                      title: 'Remark',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          5, 15, 2, 15),
                                      radius: 5,
                                      borderMode:
                                          BorderStyleMode.defaultEntryField,
                                      maxLine: 3,
                                      value: _remarkController.text,
                                      // valueChanged: (value) {
                                      //   print(
                                      //       'valueChanged _remarkController ${_remarkController.text}');
                                      //   // _remarkController.text = value;
                                      // },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 40,
                          width: 150,
                          child: TextButton(
                            onPressed: () {
                              onSaveConfirmData();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  EnvisionColor.colorGreen),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Save & Confirm',
                              style: TextStyle(
                                color: EnvisionColor.colorGrey,
                              ),
                            ),
                          ),
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

  void btnSearchPatientClick(BuildContext context) {
    var insertProvider = context.read<MdiInsertController>();
    showModalBottomSheet<MdiDataViewModel>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: (MediaQuery.of(context).size.height / 1.2),
          child: PopupSearchPatient(
              modalityId:
                  context.read<MdiInsertController>().modality.modalityId
              // orgId: org.organizationId, locationId: location.locationId
              ),
        );
      },
    ).then((value) {
      if (value != null) {
        insertProvider.setMdiData(value);
        context
            .read<MdiInsertController>()
            .setMessageLastUpdate(DateTime.now());
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

  onSaveConfirmData() {
    final mdiProvider = context.read<MdiViewModel>();
    final insertProvider = context.read<MdiInsertController>();
    String warning = checkData();
    if (warning == '') {
      _showConfirmDialog(context, 'Save & Confirm Data ?', '', () async {
        String remark = _remarkController.text;
        Navigator.pop(context, 'OK');
        insertProvider.mdiData.isConfirmed = 1;
        insertProvider.mdiData.confirmedByUid = insertProvider.confirmedByUid;
        insertProvider.mdiData.comment = remark;
        insertProvider.mdiData.orgId =
            insertProvider.organization.organizationId!;
        insertProvider.toggleRefresh();
        await mdiProvider
            .setEditMdiData(insertProvider.mdiData, 1)
            .then((value) {
          var header = '';
          var datail = '${value.acknowledgementCode} : ${value.textMessage}';
          if (value.acknowledgementCode == 'AA') {
            header = 'Success confirm data HN: ${insertProvider.mdiData.hn}';
            _remarkController.text = '';
            insertProvider.setMdiData(MdiDataViewModel());
            _focusNode.requestFocus();
            context.read<MdiInsertController>().setMessage(header);
          } else {
            header = 'Fail to Confirm data.';
            _showAlertDialog(context, header, datail);
            _focusNode.requestFocus();
          }
        });
        context.read<MdiInsertController>().toggleRefresh();
      });
      // setState(() {
      _focusNode.requestFocus();
      // });
      // print(2);
    } else {
      _focusEnterNode.requestFocus();
      _showAlertDialog(context, 'Please fill data. ', warning);
    }
  }

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

  String checkData() {
    final insertProvider = context.read<MdiInsertController>();
    String warning = '';

    if (insertProvider.confirmedByUid == '') {
      return warning += 'Please login again \n';
    }

    if (insertProvider.mdiData.hn == '' || insertProvider.mdiData.hn == null) {
      return warning += 'Please enter HN \n';
    }
    if (insertProvider.mdiData.spO2 == null) {
      warning += '• SpO2\n';
    }
    if (insertProvider.mdiData.temperature == null) {
      warning += '• Temperature\n';
    }
    if (insertProvider.mdiData.respirationRate == null) {
      warning += '• Respiration Rate\n';
    }
    if (insertProvider.mdiData.painScale == null) {
      warning += '• Pain scale\n';
    }
    if (insertProvider.mdiData.patientWeight == null) {
      warning += '• Patient Weight\n';
    }
    if (insertProvider.mdiData.patientHeight == null) {
      warning += '• Patient Height\n';
    }
    if (insertProvider.mdiData.patientBmi == null) {
      warning += '• Patient BMI\n';
    }
    if (_remarkController.text.isEmpty) {
      warning += '• Remark\n';
    }
    return warning;
    // if (mdiData.orgId == '' || mdiData.orgId == null) {
    //   return warning += 'Please enter orgId \n';
    // }
    // if (mdiData.visitNo == null ||
    //     mdiData.patientVisitId == null ||
    //     mdiData.dataId == null) {
    //   return warning += 'HN dosen\'t have visit today\n';
    // }
    // if (mdiData.pulseRate == null) {
    //   return false;
    // }
    // if (mdiData.bloodPressureSystolic == null) {
    //   return false;
    // }
    // if (mdiData.bloodPressureDiastolic == null) {
    //   return false;
    // }
    // if (mdiData.bloodPressureMean == null) {
    //   return false;
    // }
    // if (mdiData.confirmedByUid == null) {
    //   return false;
    // }
    // if (mdiData.patientType == null) {
    //   return false;
    // }
    // if (mdiData.comaEScore == null) {
    //   return false;
    // }
    // if (mdiData.comaVScore == null) {
    //   return false;
    // }
    // if (mdiData.comaMScore == null) {
    //   return false;
    // }
    // if (mdiData.smokingStatus == null) {
    //   return false;
    // }
    // if (mdiData.cvRiskScore == null) {
    //   return false;
    // }
    // if (mdiData.mewsScore == null) {
    //   return false;
    // }
  }

  Future _searchHN(String hn) async {
    var insertProvider = context.read<MdiInsertController>();
    var mdiProvider = context.read<MdiViewModel>();
    insertProvider.toggleLoadingHn();
    insertProvider.setMessage('');
    if (hn != '') {
      insertProvider.setMdiData(MdiDataViewModel(hn: hn));
      await mdiProvider
          .getSelectDataByHn(hn, insertProvider.organization.organizationId!)
          .then((value) {
        if (mdiProvider.data.hn != null) {
          insertProvider.setMdiData(mdiProvider.data);
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
  }

  bool isRefresh() {
    var insertProvider = context.read<MdiInsertController>();
    bool isRefresh = true;
    if (insertProvider.mdiData.visitNo != null &&
        insertProvider.mdiData.patientWeight != null &&
        insertProvider.mdiData.patientHeight != null &&
        insertProvider.mdiData.bloodPressureDiastolic != null &&
        insertProvider.mdiData.bloodPressureMean != null &&
        insertProvider.mdiData.bloodPressureSystolic != null &&
        insertProvider.mdiData.pulseRate != null) {
      isRefresh = false;
      context.read<MdiInsertController>().setMessageLastUpdate(DateTime.now());
    }
    return isRefresh;
  }

  Future _refresh() async {
    final mdiProvider = context.read<MdiViewModel>();
    final insertProvider = context.read<MdiInsertController>();
    if (insertProvider.mdiData.visitNo != null) {
      await mdiProvider
          .getSelectDataByVN(insertProvider.mdiData.visitNo!,
              insertProvider.organization.organizationId!)
          .then((value) {
        if (mdiProvider.data.visitNo != null) {
          insertProvider.setMdiData(MdiDataViewModel.fetchData(
              insertProvider.mdiData, mdiProvider.data));
        }
      });
    } else if (insertProvider.mdiData.hn != '' &&
        insertProvider.mdiData.hn != null) {
      if (insertProvider.mdiData.dataId != null) {
        await mdiProvider
            .getSelectDataById(insertProvider.mdiData.dataId,
                insertProvider.mdiData.patientVisitId!)
            .then((value) {
          if (mdiProvider.data.lastModifiedOn!
                  .compareTo(insertProvider.mdiData.lastModifiedOn!) <
              0) {
            insertProvider.setMdiData(MdiDataViewModel.fetchData(
                insertProvider.mdiData, mdiProvider.data));
          }
        });
      } else {
        await mdiProvider
            .getSelectDataNonConfirmByHn(insertProvider.mdiData.hn!)
            .then((value) {
          insertProvider.setMdiData(MdiDataViewModel.fetchDataByHn(
              insertProvider.mdiData, mdiProvider.data));
        });
      }
    }
    context.read<MdiInsertController>().setMessageLastUpdate(DateTime.now());
    insertProvider.mdiData.confirmedByUid = insertProvider.confirmedByUid;
  }
}
