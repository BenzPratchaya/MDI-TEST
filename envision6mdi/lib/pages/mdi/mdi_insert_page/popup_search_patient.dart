import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/models/mdi/patient_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';
import 'package:envision6mdi/providers/user_provider.dart';
import 'package:envision6mdi/widgets/input_search_in_table.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class PopupSearchPatient extends StatefulWidget {
  // final int? orgId;
  // final int? locationId;
  final int? modalityId;
  const PopupSearchPatient({super.key, this.modalityId});

  @override
  State<PopupSearchPatient> createState() => _PopupSearchPatientState();
}

class _PopupSearchPatientState extends State<PopupSearchPatient> {
  double textWidth = 330;
  final tableVerticalScrollController = ScrollController();
  final tableHorizontalScrollController = ScrollController();

  List<MdiDataViewModel>? patientSearchList = [];
  List<MdiDataViewModel>? patientFilterList = [];
  Patient patientSearchItem = Patient();
  bool isLoading = false;
  UserProvider userProv = UserProvider();
  int _currentMax = 0;
  int _rowCount = 12;
  String totalPage = '';
  DateTime today = DateTime.now();
  late int orgId;
  @override
  initState() {
    tableVerticalScrollController.addListener(() {
      if (tableVerticalScrollController.position.pixels ==
          tableVerticalScrollController.position.maxScrollExtent) {
        // จะเช็คจนะกระทั้ง scroll มาเจอจุดที่ต่ำที่สุด
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProv = Provider.of<UserProvider>(context);
    return ViewModelBuilder<MdiViewModel>.reactive(
        viewModelBuilder: () => MdiViewModel(),
        onViewModelReady: (model) =>
            model.getSelectViewByModalityId(widget.modalityId).then(
              (value) {
                patientSearchList =
                    model.worklist.where((e) => e.isConfirmed == 0).toList();
                var rowCount =
                    (MediaQuery.of(context).size.height * 0.75) / 48.45;
                _rowCount = rowCount.round() - 1;
                _getMoreData();
              },
            ),
        builder: (context, model, child) => Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(child: _search()),/
                    const Divider(
                      thickness: 1,
                    ),
                    _table(),
                    Center(child: Text(totalPage)),
                  ],
                ),
              ),
            ));
  }

  void refreshTableByFilter(List<MdiDataViewModel>? list) {
    patientFilterList = list;
    if (patientFilterList != null) {
      totalPage =
          '${patientFilterList!.length}/${patientSearchList!.length}'; //คำนวณ total page ใหม่
      _currentMax = _currentMax + _rowCount;
      isLoading = false;
    }
    setState(() {});
  }

  Widget _table() {
    MdiDataViewModel model = MdiDataViewModel();
    double maxHeight = MediaQuery.of(context).size.height * 0.75;
    return isLoading
        ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue,
            size: 100,
          ))
        : SizedBox(
            width: double.infinity,
            height: maxHeight,
            child: SingleChildScrollView(
              controller: tableVerticalScrollController,
              scrollDirection: Axis.vertical,
              child: DataTable(
                showCheckboxColumn: false,
                horizontalMargin: 0,
                headingRowHeight: 70,
                columnSpacing: EnvisionSize.inputPadding,
                columns: [
                  // const DataColumn(
                  //   label: Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Text(
                  //       "Selected",
                  //     ),
                  //   ),
                  // ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputSearchInTableWidget(
                        width: 150,
                        columnName: "HN",
                        onSearchChaged: (key) {
                          List<MdiDataViewModel>? list = patientSearchList!
                              .where((value) => value.hn
                                  .toString()
                                  .toLowerCase()
                                  .contains(key.toString().toLowerCase()))
                              .toList();
                          refreshTableByFilter(list);
                        },
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputSearchInTableWidget(
                        width: 150,
                        columnName: "Visit No",
                        onSearchChaged: (key) {
                          List<MdiDataViewModel>? list = patientSearchList!
                              .where((value) => value.visitNo
                                  .toString()
                                  .toLowerCase()
                                  .contains(key.toString().toLowerCase()))
                              .toList();
                          refreshTableByFilter(list);
                        },
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputSearchInTableWidget(
                        width: 280,
                        columnName: "Patient Name",
                        onSearchChaged: (key) {
                          List<MdiDataViewModel>? list = patientSearchList!
                              .where((value) => value.patientName
                                  .toString()
                                  .toLowerCase()
                                  .contains(key.toString().toLowerCase()))
                              .toList();
                          refreshTableByFilter(list);
                        },
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputSearchInTableWidget(
                        width: 280,
                        columnName: "Location",
                        onSearchChaged: (key) {
                          List<MdiDataViewModel>? list = patientSearchList!
                              .where((value) => value.locationText
                                  .toString()
                                  .toLowerCase()
                                  .contains(key.toString().toLowerCase()))
                              .toList();
                          refreshTableByFilter(list);
                        },
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputSearchInTableWidget(
                        width: 280,
                        columnName: "WH Date Time",
                        onSearchChaged: (key) {
                          List<MdiDataViewModel>? list = patientSearchList!
                              .where((value) => value.whDateTime
                                  .toString()
                                  .toLowerCase()
                                  .contains(key.toString().toLowerCase()))
                              .toList();
                          refreshTableByFilter(list);
                        },
                      ),
                    ),
                  ),
                ],
                rows: patientFilterList!.isEmpty
                    ? []
                    : List.generate(
                        patientFilterList!.length,
                        (index) => bindingDataRow(
                            model, patientFilterList![index], index, () {}),
                      ),
              ),
            ),
          );
  }

  Future<void> _getMoreData() async {
    setState(() {
      isLoading = true;
    });
    if (patientSearchList != null) {
      if (_currentMax > patientSearchList!.length) {
        patientFilterList = patientSearchList!;
      } else {
        for (int i = _currentMax; i < (_currentMax + _rowCount); i++) {
          if (i < patientSearchList!.length) {
            // List จะถูกทำให้เพิ่มขึ้นทีละ 12 เมื่อมีการเรียก function
            patientFilterList!.add(patientSearchList![i]);
          }
        }
      }
      totalPage = '${patientFilterList!.length}/${patientSearchList!.length}';
      _currentMax =
          _currentMax + _rowCount; // currentMax จึงต้องเพิ่มด้วย ทีละ 12 ด้วย
      _table(); // binding Data Row ใหม่
    }
    isLoading = false;
  }

  DataRow bindingDataRow(MdiDataViewModel model, MdiDataViewModel dataInfo,
      int index, Function() onTap) {
    return DataRow(
      cells: [
        // DataCell(
        //     onTap: () => Navigator.pop(context, dataInfo),
        //     Container(
        //         alignment: Alignment.center,
        //         child: const Icon(Icons.add_circle))),
        DataCell(
            // onTap: () => Navigator.pop(context, dataInfo),
            Container(alignment: Alignment.center, child: Text(dataInfo.hn!))),
        DataCell(
            // onTap: () => Navigator.pop(context, dataInfo),
            Container(
                alignment: Alignment.center, child: Text(dataInfo.visitNo!))),
        DataCell(
            // onTap: () => Navigator.pop(context, dataInfo),
            Container(
                alignment: Alignment.center,
                child: Text(dataInfo.patientName!))),
        DataCell(
            // onTap: () => Navigator.pop(context, dataInfo),
            Container(
                alignment: Alignment.center,
                child: Text(dataInfo.locationText!))),
        DataCell(
            // onTap: () => Navigator.pop(context, dataInfo),
            Container(
                alignment: Alignment.center,
                child: Text('${dataInfo.whDateTime}'))),
      ],
      onSelectChanged: (value) => Navigator.pop(context, dataInfo),
    );
  }
}
