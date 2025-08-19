import 'package:envision6mdi/pages/config_page/setting_setup/setting.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../helpers/constants.dart';
import '../../modelviews/mdiconfig_view_model.dart';
import '../../widgets/container_widget.dart';
import 'location_setup/location_setup.dart';
import 'user_setup/user_setup.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MdiConfigViewModel>.reactive(
        viewModelBuilder: () => MdiConfigViewModel(),
        onViewModelReady: (model) => model.prepareConfigData(),
        builder: (context, model, child) => SafeArea(
                child: Container(
              color: EnvisionColor.secondaryColor,
              padding: const EdgeInsets.all(EnvisionSize.widgetPadding),
              child: ContainerWidget(
                  child: Scaffold(
                appBar: AppBar(
                  // title: const Text('TabBar Widget'),
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: 'User Setup',
                      ),
                      Tab(
                        text: 'Modality Setup',
                      ),
                      Tab(
                        text: 'Location Setup',
                      ),
                      Tab(
                        text: 'Setting',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Center(
                      child: UserSetupWidget(
                        model: model,
                      ),
                    ),
                    // Center(
                    //   child: ModalitySetupWidget(
                    //     model: model,
                    //   ),
                    // ),
                    Center(
                      child: LocationSetupWidget(
                        model: model,
                      ),
                    ),
                    Center(
                      child: SettingWidget(
                        model: model,
                      ),
                    ),
                  ],
                ),
              )),
            )));
  }
}
