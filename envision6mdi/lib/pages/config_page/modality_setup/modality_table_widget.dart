import 'package:flutter/material.dart';

import '../../../models/mdi/modality_model.dart';

import '../../../modelviews/modality_config_view_model.dart';

import '../../../widgets/table_column_search.dart';
import 'modality_form_widget.dart';

class ModalityTableWidget extends StatefulWidget {
  const ModalityTableWidget(
      {super.key, required this.modalityList, required this.model});
  final List<Modality> modalityList;
  final ModalityConfigViewModel model;

  @override
  State<ModalityTableWidget> createState() => _ModalityTableWidgetState();
}

List<Modality> modalityList = [];

class _ModalityTableWidgetState extends State<ModalityTableWidget> {
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    modalityList = widget.modalityList;
    return DataTable(
        columns: [
          const DataColumn(label: Text('')),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Modality Code',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Modality Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Modality Type',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Modality Host',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Default Location',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 150,
            columnFontColor: Colors.black,
            columnname: 'Default SubLocation',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'organization',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Auto Confirm',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Is delete',
            onSearchChaged: (String value) {
              setState(() {});
            },
          ))
        ],
        rows: List.generate(
          modalityList.length,
          (index) => bindingDataRow(modalityList[index], index, () {}, context),
        ));
  }

  DataRow bindingDataRow(
      Modality data, int index, Function() onTap, BuildContext context) {
    return DataRow(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          await widget.model.prepareModalityEdit(data).then(
              (value) => _showEdittingDialog(context, widget.model, data));
        },
      )),
      DataCell(Text(data.modalityUid ?? '')),
      DataCell(Text(data.modalityName ?? '')),
      DataCell(Text(data.modalityTypeAlias ?? '')),
      DataCell(Text(data.modalityHost ?? '')),
      DataCell(Text(data.defaultLocationText ?? '')),
      DataCell(Text(data.defaultSubLocationText ?? '')),
      DataCell(Text(data.organizationName ?? '')),
      DataCell(Text(data.autoConfirm == 1 ? 'Auto Confirm' : '')),
      DataCell(Text(data.isDeleted == 1 ? 'deleted' : '')),
    ]);
  }

  _showEdittingDialog(context, model, Modality data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => ModalityFormWidget(
            context: context,
            model: model,
            // modalityData: data,
            isEdit: true,
            onDataChanged: (value) => {
                  setState(() {
                    modalityList = value;
                  })
                }));
  }
}
