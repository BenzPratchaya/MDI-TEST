import 'package:envision6mdi/pages/config_page/sub_location_setup/sub_location_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../helpers/constants.dart';
// import '../../../models/mdi/location_model.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../models/mdi/sub_location_model.dart';
import '../../../modelviews/mdiconfig_view_model.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/round_btn_widget.dart';
import 'sub_location_form_widget.dart';

class SubLocationSetupPage extends StatefulWidget {
  const SubLocationSetupPage({super.key});

  @override
  State<SubLocationSetupPage> createState() => _SubLocationSetupPageState();
}

final _scrollController = ScrollController();
final tableHorizontalScrollController = ScrollController();

class _SubLocationSetupPageState extends State<SubLocationSetupPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)!;
    return ViewModelBuilder<MdiConfigViewModel>.reactive(
      viewModelBuilder: () => MdiConfigViewModel(),
      onViewModelReady: (model) => model.prepareSubLocationData(
          user.user.organizationId ?? 1, user.user.userId!),
      builder: (context, model, child) => SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              organizationList: model.organizationList,
              showSearch: false,
              title: 'Envision MDI',
              onOrgChanged: (Organization value) {
                setState(() {
                  model.prepareSubLocationData(
                      value.organizationId!, user.user.userId!);
                });
              },
            ),
            ContainerWidget(
                height: MediaQuery.of(context).size.height - 68 - 8,
                borderRadius: 0,
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: tableHorizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RoundButtonWidget(
                                onTap: () async {
                                  await model
                                      .prepareSubLocationEdit(SubLocation())
                                      .then((value) => _showAddDialog(
                                          context, model, SubLocation()));
                                },
                                title: 'Add',
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: EnvisionSize.widgetPadding,
                          ),
                          SubLocationTableWidget(
                              subLocationList: model.subLocationList,
                              model: model),
                        ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _showAddDialog(context, model, SubLocation data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SubLocationFormWidget(
            context: context,
            model: model,
            subLocationData: data,
            onDataChanged: (value) => {
                  setState(() {
                    subLocationList = value;
                  })
                }));
  }
}
