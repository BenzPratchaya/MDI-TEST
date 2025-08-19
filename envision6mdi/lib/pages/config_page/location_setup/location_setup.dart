import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../models/mdi/location_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/round_btn_widget.dart';
import 'user_form_widget.dart';

class LocationSetupWidget extends StatefulWidget {
  const LocationSetupWidget({super.key, required this.model});
  final MdiConfigViewModel model;

  @override
  State<LocationSetupWidget> createState() => _LocationSetupWidgetState();
}

class _LocationSetupWidgetState extends State<LocationSetupWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
        borderRadius: 0,
        alignment: Alignment.topLeft,
        child: ContainerWidget(
          borderRadius: 0,
          alignment: Alignment.topLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                RoundButtonWidget(
                  onTap: () =>
                      {_showAddDialog(context, widget.model, Location())},
                  title: 'Add',
                  icon: Icons.add,
                ),
              ],
            ),
            const SizedBox(
              height: EnvisionSize.widgetPadding,
            ),
            // UserTableWidget(userList: widget.model.userList, model: widget.model),
          ]),
        ));
  }

  _showAddDialog(context, model, Location data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => LocationFormWidget(
            context: context, model: model, locationData: data));
  }
}
