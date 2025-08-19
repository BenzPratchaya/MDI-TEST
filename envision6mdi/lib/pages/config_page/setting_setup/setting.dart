import 'package:envision6mdi/pages/config_page/setting_setup/setting_table_widget.dart';
import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../widgets/container_widget.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key, required this.model});
  final MdiConfigViewModel model;

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
        borderRadius: 0,
        alignment: Alignment.topLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Row(
          //   children: [
          //     RoundButtonWidget(
          //       onTap: () => {},
          //       title: 'Add',
          //       icon: Icons.add,
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: EnvisionSize.widgetPadding,
          ),
          SettingTableWidget(model: widget.model),
        ]));
  }
}
