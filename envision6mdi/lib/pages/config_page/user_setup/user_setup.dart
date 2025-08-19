import 'package:envision6mdi/models/mdi/user_model.dart';
import 'package:envision6mdi/pages/config_page/user_setup/user_form_widget.dart';
import 'package:envision6mdi/pages/config_page/user_setup/user_table_widget.dart';
import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/round_btn_widget.dart';

class UserSetupWidget extends StatefulWidget {
  const UserSetupWidget({super.key, required this.model});
  final MdiConfigViewModel model;

  @override
  State<UserSetupWidget> createState() => _UserSetupWidgetState();
}

class _UserSetupWidgetState extends State<UserSetupWidget> {
  @override
  Widget build(BuildContext context) {
    return
        //  ViewModelBuilder<MdiConfigViewModel>.reactive(
        //     viewModelBuilder: () => MdiConfigViewModel(),
        //     onViewModelReady: (model) => model.prepareConfigData(),
        //     builder: (context, model, child) => SafeArea(
        //             child:
        ContainerWidget(
      borderRadius: 0,
      alignment: Alignment.topLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            RoundButtonWidget(
              onTap: () => {_showAddDialog(context, widget.model, User())},
              title: 'Add',
              icon: Icons.add,
            ),
          ],
        ),
        const SizedBox(
          height: EnvisionSize.widgetPadding,
        ),
        UserTableWidget(userList: widget.model.userList, model: widget.model),
      ]),
      // ) )
    );
  }

  _showAddDialog(context, model, User data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            UserFormWidget(context: context, model: model, userData: data));
  }
}
