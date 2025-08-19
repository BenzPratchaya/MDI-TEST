import 'package:envision6mdi/models/mdi/modality_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../helpers/constants.dart';
import '../../../models/mdi/organization_model.dart';
import '../../../modelviews/modality_config_view_model.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/container_widget.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/round_btn_widget.dart';
import 'modality_form_widget.dart';
import 'modality_table_widget.dart';

class ModalitySetupPage extends StatefulWidget {
  const ModalitySetupPage({super.key});

  @override
  State<ModalitySetupPage> createState() => _ModalitySetupPageState();
}

class _ModalitySetupPageState extends State<ModalitySetupPage> {
  final _scrollController = ScrollController();
  final tableHorizontalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)!;
    return ViewModelBuilder<ModalityConfigViewModel>.reactive(
        viewModelBuilder: () => ModalityConfigViewModel(),
        onViewModelReady: (model) => model.prepareModalityData(
            user.user.organizationId ?? 1, user.user.userId!),
        builder: (context, model, child) => SafeArea(
              child: Column(
                children: [
                  HeaderWidget(
                      organizationList: model.organizationList,
                      showSearch: false,
                      title: 'Envision MDI',
                      onOrgChanged: (Organization value) => setState(() {
                            model.prepareModalityData(
                                user.user.organizationId ?? 1,
                                user.user.userId!);
                          })),
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
                                          .prepareModalityEdit(Modality())
                                          .then((value) => _showAddDialog(
                                                context,
                                                model,
                                                Modality(),
                                              ));
                                    },
                                    title: 'Add',
                                    icon: Icons.add,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: EnvisionSize.widgetPadding,
                              ),
                              ModalityTableWidget(
                                  modalityList: model.modalityList,
                                  model: model),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  _showAddDialog(context, ModalityConfigViewModel model, Modality data) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => ModalityFormWidget(
              context: context,
              model: model,
              // modalityData: data,
              onDataChanged: (value) {
                setState(() {
                  modalityList = value;
                });
              },
            ));
  }
}
