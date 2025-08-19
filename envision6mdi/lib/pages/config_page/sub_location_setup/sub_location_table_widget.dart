import 'package:envision6mdi/pages/config_page/sub_location_setup/sub_location_form_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/mdi/sub_location_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/table_column_search.dart';

class SubLocationTableWidget extends StatefulWidget {
  const SubLocationTableWidget(
      {super.key, required this.subLocationList, required this.model});
  final List<SubLocation> subLocationList;
  final MdiConfigViewModel model;

  @override
  State<SubLocationTableWidget> createState() => _SubLocationTableWidgetState();
}

List<SubLocation> subLocationList = [];

class _SubLocationTableWidgetState extends State<SubLocationTableWidget> {
  @override
  Widget build(BuildContext context) {
    subLocationList = widget.subLocationList;
    return DataTable(
        columns: [
          const DataColumn(label: Text('')),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            isSearch: false,
            columnFontColor: Colors.black,
            columnname: 'subLocation Code',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            columnFontColor: Colors.black,
            columnname: 'subLocation Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            columnFontColor: Colors.black,
            columnname: 'subLocation Desc',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Location',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Building',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 75,
            columnFontColor: Colors.black,
            columnname: 'Floor',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 75,
            columnFontColor: Colors.black,
            columnname: 'Room',
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
            columnname: 'Is delete',
            onSearchChaged: (String value) {
              setState(() {});
            },
          ))
        ],
        rows: List.generate(
          subLocationList.length,
          (index) =>
              bindingDataRow(subLocationList[index], index, () {}, context),
        ));
  }

  DataRow bindingDataRow(
      SubLocation data, int index, Function() onTap, BuildContext context) {
    return DataRow(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          await widget.model.prepareSubLocationEdit(data).then(
              (value) => _showEdittingDialog(context, widget.model, data));
        },
      )),
      DataCell(Text(data.subLocationUid ?? '')),
      DataCell(Text(data.subLocationName ?? '')),
      DataCell(Text(data.subLocationDesc ?? '')),
      DataCell(Text(data.locationText ?? '')),
      DataCell(Text(data.subLocationBuilding ?? '')),
      DataCell(Text(data.subLocationFloor ?? '')),
      DataCell(Text(data.subLocationRoom ?? '')),
      DataCell(Text(data.organizationName ?? '')),
      DataCell(Text(data.isDeleted == 1 ? 'deleted' : '')),
    ]);
  }

  _showEdittingDialog(context, model, SubLocation data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SubLocationFormWidget(
            context: context,
            model: model,
            subLocationData: data,
            isEdit: true,
            onDataChanged: (value) => {
                  setState(() {
                    subLocationList = value;
                  })
                }));
  }
}
