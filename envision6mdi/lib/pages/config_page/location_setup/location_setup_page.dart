import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../helpers/constants.dart';
// import '../../../models/mdi/location_model.dart';
import '../../../models/mdi/location_model.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../modelviews/location_config_view_model.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/round_btn_widget.dart';
import 'location_form_widget.dart';
import 'location_table_widget.dart';

class LocationSetupPage extends StatefulWidget {
  const LocationSetupPage({super.key});

  @override
  State<LocationSetupPage> createState() => _LocationSetupPageState();
}

final _scrollController = ScrollController();
final tableHorizontalScrollController = ScrollController();

class _LocationSetupPageState extends State<LocationSetupPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)!;
    return ViewModelBuilder<LocationConfigViewModel>.reactive(
      viewModelBuilder: () => LocationConfigViewModel(),
      onViewModelReady: (model) => model.prepareLocationData(
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
                  model.prepareLocationData(
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
                                      .prepareLocationEdit(Location())
                                      .then((value) => _showAddDialog(
                                          context, model, Location()));
                                },
                                title: 'Add',
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: EnvisionSize.widgetPadding,
                          ),
                          LocationTableWidget(
                              locationList: model.locationList, model: model),
                        ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _showAddDialog(context, LocationConfigViewModel model, Location data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => LocationFormWidget(
            context: context,
            model: model,
            locationData: data,
            onDataChanged: (value) => {
                  setState(() {
                    locationList = value;
                  })
                }));
  }
}
