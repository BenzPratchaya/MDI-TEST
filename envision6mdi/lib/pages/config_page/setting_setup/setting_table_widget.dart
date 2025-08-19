import 'package:flutter/material.dart';

import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/table_column_search.dart';

class SettingTableWidget extends StatefulWidget {
  const SettingTableWidget({super.key, required this.model});
  final MdiConfigViewModel model;

  @override
  State<SettingTableWidget> createState() => _SettingTableWidgetState();
}

class _SettingTableWidgetState extends State<SettingTableWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      width: MediaQuery.of(context).size.width - 80,
      child: DataTable(columns: [
        DataColumn(
            label: DataColumnSearch(
          columnFontColor: Colors.black,
          columnname: 'Key',
          onSearchChaged: (String value) {
            setState(() {});
          },
        )),
        DataColumn(
            label: DataColumnSearch(
          columnFontColor: Colors.black,
          columnname: 'Value',
          onSearchChaged: (String value) {
            setState(() {});
          },
        )),
      ], rows: const [
        DataRow(cells: [
          DataCell(Text('')),
          DataCell(Text('')),
        ])
      ] // rows: List.generate(
          //   userList.length,
          //   (index) => bindingDataRow(userList[index], index, () {}, context),
          // ),
          ),
    );
  }
}
