import 'package:envision6mdi/pages/config_page/user_setup/user_form_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/mdi/user_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/table_column_search.dart';

class UserTableWidget extends StatefulWidget {
  const UserTableWidget(
      {super.key, required this.userList, required this.model});
  final List<User> userList;
  final MdiConfigViewModel model;
  @override
  State<UserTableWidget> createState() => _UserTableWidgetState();
}

List<User> userList = [];

class _UserTableWidgetState extends State<UserTableWidget> {
  @override
  Widget build(BuildContext context) {
    userList = widget.userList;
    return ContainerWidget(
      width: MediaQuery.of(context).size.width - 80,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('')),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'User Code',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'User Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'English Name',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'User Type',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Organize',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
          DataColumn(
              label: DataColumnSearch(
            columnFontColor: Colors.black,
            columnname: 'Is Deleted',
            onSearchChaged: (String value) {
              setState(() {});
            },
          )),
        ],
        rows: List.generate(
          userList.length,
          (index) => bindingDataRow(userList[index], index, () {}, context),
        ),
      ),
    );
  }

  DataRow bindingDataRow(
      User data, int index, Function() onTap, BuildContext context) {
    return DataRow(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          _showEdittingDialog(context, widget.model, data);
        },
      )),
      DataCell(Text(data.userUid ?? '')),
      DataCell(Text(data.userName ?? '')),
      DataCell(Text(
          '${data.userTitle ?? ''} ${data.userFName ?? ''} ${data.userMName ?? ''} ${data.userLName ?? ''}')),
      DataCell(Text(
          '${data.userTitleEng ?? ''} ${data.userFNameEng ?? ''} ${data.userMNameEng ?? ''} ${data.userLNameEng ?? ''}')),
      DataCell(Text(data.userType ?? '')),
      DataCell(Text(data.organizationId.toString())),
      DataCell(Text(data.isDeleted == 1 ? 'deleted' : 'active')),
    ]);
  }

  _showEdittingDialog(context, model, User data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => UserFormWidget(
              context: context,
              model: model,
              userData: data,
              isEdit: true,
            ));
  }
}
