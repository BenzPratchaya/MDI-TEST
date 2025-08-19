import 'package:envision6mdi/helpers/constants.dart';
import 'package:envision6mdi/models/mdi/mdi_column_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/modelviews/mdi_view_model.dart';

import 'package:envision6mdi/pages/mdi/mdi_worklist/mdi_detail.dart';
import 'package:envision6mdi/pages/mdi/mdi_worklist/mdi_form_confirm.dart';
import 'package:envision6mdi/widgets/table_column_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MdiWorklistTable extends StatelessWidget {
  final MdiViewModel model;
  final List<MdiDataViewModel> worklist;
  final ValueChanged<List<MdiDataViewModel>> onDataChanged;
  final ValueChanged<bool> onLoadMore;
  final bool isLoadingData;
  const MdiWorklistTable({
    super.key,
    required this.model,
    required this.worklist,
    required this.onDataChanged,
    required this.onLoadMore,
    this.isLoadingData = false,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 60,
      columnSpacing: 10,
      dataRowMaxHeight: 80,
      headingRowColor: WidgetStateColor.resolveWith(
          (states) => EnvisionColor.primaryColor.withOpacity(0.5)),
      columns: column(),
      rows: List.generate(
        worklist.length,
        (index) => bindingDataRow(worklist[index], index, () {}, context),
      ),
    );
  }

  List<DataColumn> column() {
    return [
      const DataColumn(label: Text('')),
      DataColumn(
          label: Expanded(
        child: DataColumnSearch(
          columnname: 'Create On',
          onSearchChaged: (String value) {
            var columnSearch = MdiColumnModel();
            columnSearch.createOn = value;
            _searchColumn(columnSearch);
          },
        ),
      )),
      DataColumn(
          label: Expanded(
        child: DataColumnSearch(
          columnname: 'HN',
          columnFontColor: EnvisionColor.secondaryColor,
          columnInputColor: EnvisionColor.secondaryColor,
          onSearchChaged: (String value) {
            var columnSearch = MdiColumnModel();
            columnSearch.hn = value;
            _searchColumn(columnSearch);
          },
        ),
      )),
      DataColumn(
          label: DataColumnSearch(
        width: 300,
        columnname: '',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.age = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: '',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.weight = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Blood Pressure',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Pulse',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.pulse = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Temp',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.temp = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Pain Score',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'GCS',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: '',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: '',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Status',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.status = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Location',
        onSearchChaged: (String value) {
          var columnSearch = MdiColumnModel();
          columnSearch.location = value;
          _searchColumn(columnSearch);
        },
      )),
      DataColumn(
          label: DataColumnSearch(
        columnname: 'Modality',
        onSearchChaged: (String value) {
          // columnSearch.status = value;
          //  _searchColumn(columnSearch);
        },
      )),
    ];
  }

  _searchColumn(MdiColumnModel columnSearch) {
    // isLoadingData = true;
    var worklist = model.worklist;

    if (columnSearch.hn != null &&
        columnSearch.hn != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.hn
              .toString()
              .toLowerCase()
              .contains(columnSearch.hn!.toLowerCase()))
          .toList();
    }

    if (columnSearch.visitNo != null &&
        columnSearch.visitNo != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.visitNo
              .toString()
              .toLowerCase()
              .contains(columnSearch.visitNo!.toLowerCase()))
          .toList();
    }

    if (columnSearch.patientName != null &&
        columnSearch.patientName != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientName
              .toString()
              .toLowerCase()
              .contains(columnSearch.patientName!.toLowerCase()))
          .toList();
    }

    if (columnSearch.age != null &&
        columnSearch.age != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientAgeText
              .toString()
              .toLowerCase()
              .contains(columnSearch.age!.toLowerCase()))
          .toList();
    }

    if (columnSearch.sex != null &&
        columnSearch.sex != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientGenderText
              .toString()
              .toLowerCase()
              .contains(columnSearch.sex!.toLowerCase()))
          .toList();
    }

    if (columnSearch.location != null &&
        columnSearch.location != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.locationText
              .toString()
              .toLowerCase()
              .contains(columnSearch.location!.toLowerCase()))
          .toList();
    }

    if (columnSearch.patType != null &&
        columnSearch.patType != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientType
              .toString()
              .toLowerCase()
              .contains(columnSearch.patType!.toLowerCase()))
          .toList();
    }

    if (columnSearch.pulse != null &&
        columnSearch.pulse != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.pulseRateText
              .toString()
              .toLowerCase()
              .contains(columnSearch.pulse!.toLowerCase()))
          .toList();
    }

    if (columnSearch.spo2 != null &&
        columnSearch.spo2 != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.spo2Text
              .toString()
              .toLowerCase()
              .contains(columnSearch.spo2!.toLowerCase()))
          .toList();
    }

    if (columnSearch.temp != null &&
        columnSearch.temp != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.temperatureText
              .toString()
              .toLowerCase()
              .contains(columnSearch.temp!.toLowerCase()))
          .toList();
    }

    if (columnSearch.weight != null &&
        columnSearch.weight != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientWeightText
              .toString()
              .toLowerCase()
              .contains(columnSearch.weight!.toLowerCase()))
          .toList();
    }

    if (columnSearch.height != null &&
        columnSearch.height != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientHeightText
              .toString()
              .toLowerCase()
              .contains(columnSearch.height!.toLowerCase()))
          .toList();
    }

    if (columnSearch.bmi != null &&
        columnSearch.bmi != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.patientBmi
              .toString()
              .toLowerCase()
              .contains(columnSearch.bmi!.toLowerCase()))
          .toList();
    }

    if (columnSearch.status != null &&
        columnSearch.status != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.dataStatusText
              .toString()
              .toLowerCase()
              .contains(columnSearch.status!.toLowerCase()))
          .toList();
    }

    if (columnSearch.createOn != null &&
        columnSearch.createOn != '' &&
        worklist.isNotEmpty) {
      worklist = worklist
          .where((wl) => wl.createdOn
              .toString()
              .toLowerCase()
              .contains(columnSearch.createOn!.toLowerCase()))
          .toList();
    }

    onDataChanged(worklist);
  }

  DataRow bindingDataRow(MdiDataViewModel data, int index, Function() onTap,
      BuildContext context) {
    return DataRow(
        onLongPress: () {
          _showDetailDialog(context, model, data);
        },
        cells: [
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  model
                      .getSelectDataDetail(data.dataId!)
                      .then((value) => _showDetailDialog(context, model, data));
                },
              ),
              MaterialButton(
                onPressed: () async {
                  // model.getSelectDataById(data.dataId ?? -1).then(
                  // (value) =>
                  _showConfirmDialog(context, model, data);
                  // );
                },
                color: data.isConfirmed == 1
                    ? EnvisionColor.colorGreen
                    : EnvisionColor.fontHintColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(14),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.done_sharp,
                  size: 20,
                ),
              )
            ],
          )),
          DataCell(Text(DateFormat(EnvisionFormat.displayFormattedDateTime)
              .format(data.createdOn!))),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('HN', data.hn),
              Text(data.patientName ?? ''),
              chipWord('Visit', data.visitNo),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('Age ', data.patientAgeText),
              chipWord('Sex', data.patientGenderText),
              chipWord('PT', data.patientTypeText),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('Weight', data.patientWeightText),
              chipWord('Height', data.patientHeightText),
              chipWord('BMI', '${data.patientBmi ?? ''}'),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.bloodPressureText ?? ''),
              // chipWord('Method', data.bloodPressureMethod),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('Pulse Rate', data.pulseRateText),
              chipWord('Respiration Rate', '${data.respirationRate ?? ''}'),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('Temperature', data.temperatureText),
              chipWord('spo2', data.spo2Text),
            ],
          )),
          DataCell(Text('${data.painScale ?? ''}')),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('E', data.comaEScoreText ?? ''),
              chipWord('V', data.comaVScoreText ?? ''),
              chipWord('M', data.comaMScoreText ?? ''),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('Smoking Status', data.smokingStatusText ?? ''),
              chipWord('Smoking Hsi', '${data.smokingHsi ?? ''}'),
            ],
          )),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipWord('CvRisk Score', '${data.cvRiskScore ?? ''}'),
              chipWord('Fall Risk Type', data.fallRiskTypeText ?? ''),
            ],
          )),
          DataCell(Text(data.dataStatusText ?? '')),
          DataCell(Text(data.locationText ?? '')),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // chipWord('Vs', data.modalityVsText),
              chipWord('Wh', data.modalityWhText),
            ],
          )),
        ]);
  }

  Widget chipWord(String header, String? text) {
    return Visibility(
        visible: text != '',
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '$header : ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: text ?? ' ',
              ),
            ],
          ),
        ));
  }

  //dialog

  _showDetailDialog(context, model, MdiDataViewModel data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            MdiDetail(context: context, model: model, mdiData: data));
  }

  Future _showConfirmDialog(
      context, MdiViewModel model, MdiDataViewModel data) async {
    await model.getSelectDataById(data.dataId, data.patientVisitId!);
    data = model.data;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => MdiFormConfirm(
        context: context,
        model: model,
        mdiData: data,
        onDataChanged: (value) {
          onDataChanged(model.worklist);
        },
      ),
    );
  }
}
