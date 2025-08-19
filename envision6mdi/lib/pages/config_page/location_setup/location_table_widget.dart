import 'package:flutter/material.dart';

import '../../../models/mdi/location_model.dart';
import '../../../modelviews/location_config_view_model.dart';
import '../../../widgets/table_column_search.dart';
import 'location_form_widget.dart';

class LocationTableWidget extends StatefulWidget {
  const LocationTableWidget(
      {super.key, required this.locationList, required this.model});
  final List<Location> locationList;
  final LocationConfigViewModel model;

  @override
  State<LocationTableWidget> createState() => _LocationTableWidgetState();
}

List<Location> locationList = [];

class _LocationTableWidgetState extends State<LocationTableWidget> {
  @override
  Widget build(BuildContext context) {
    locationList = widget.locationList;
    return DataTable(
        columns: [
          const DataColumn(label: Text('')),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            isSearch: false,
            columnFontColor: Colors.black,
            columnname: 'Location Code',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            columnFontColor: Colors.black,
            columnname: 'Location Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            width: 125,
            columnFontColor: Colors.black,
            columnname: 'Location Desc',
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
          )),
        ],
        rows: List.generate(
          locationList.length,
          (index) => bindingDataRow(locationList[index], index, () {}, context),
        ));
  }

  DataRow bindingDataRow(
      Location data, int index, Function() onTap, BuildContext context) {
    return DataRow(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          await widget.model.prepareLocationEdit(data).then(
              (value) => _showEdittingDialog(context, widget.model, data));
        },
      )),
      DataCell(Text(data.locationUid ?? '')),
      DataCell(Text(data.locationName ?? '')),
      DataCell(Text(data.locationDesc ?? '')),
      DataCell(Text(data.organizationName ?? '')),
      DataCell(Text(data.isDeleted == 1 ? 'deleted' : '')),
    ]);
  }

  _showEdittingDialog(context, model, Location data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => LocationFormWidget(
            context: context,
            model: model,
            locationData: data,
            isEdit: true,
            onDataChanged: (value) => {
                  setState(() {
                    locationList = value;
                  })
                }));
  }
}
