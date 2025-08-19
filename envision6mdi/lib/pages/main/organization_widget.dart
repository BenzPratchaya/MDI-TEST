import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../models/mdi/organization_model.dart';

class OrganizationWidget extends StatefulWidget {
  const OrganizationWidget(
      {super.key,
      required this.orgId,
      required this.organizationList,
      required this.onOrgChanged});
  final int orgId;
  final List<Organization> organizationList;
  final ValueChanged<Organization> onOrgChanged;

  @override
  State<OrganizationWidget> createState() => _OrganizationWidgetState();
}

class _OrganizationWidgetState extends State<OrganizationWidget> {
  // late List<Organization> _organizationList = [];
  late int orgId;
  @override
  Widget build(BuildContext context) {
    setState(() {
      orgId = widget.orgId;
    });
    var selectorganizationList = widget.organizationList
        .where((e) => e.organizationId == orgId)
        .toList();
    var organization =
        selectorganizationList.isNotEmpty ? selectorganizationList.first : null;
    return
        // ViewModelBuilder<AuthenticationService>.reactive(
        //     viewModelBuilder: () => AuthenticationService(),
        //     onViewModelReady: (model) =>
        //         model.getOrganizationSelectView().then((value) {
        //           setState(() {
        //             _organizationList = value;
        //           });
        //         }),
        //     builder: (context, model, child) => SafeArea(
        //           child:
        Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 55, 80, 97),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 200,
            // height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                style: const TextStyle(
                  fontSize: 18,
                  color: EnvisionColor.colorGrey,
                ),
                // isDense: true
                dropdownColor: EnvisionColor.colorBlue,
                // focusColor: EnvisionColor.focusColor,
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                value: organization,
                items: widget.organizationList.map((Organization items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.organizationName!),
                  );
                }).toList(),
                onChanged: (organization) {
                  widget.onOrgChanged(organization!);
                  setState(() {
                    orgId = organization.organizationId!;
                  });
                  // user.user.organizationId = organization?.organizationId;
                  // // Future.delayed(Duration.zero, () async {
                  // User u = user.user;
                  // // organization;
                  // u.organizationId = organization?.organizationId;
                  // user.setUser(u);
                  // });
                },
                hint: const Text(
                  'Select Organization',
                  style: TextStyle(
                    color: EnvisionColor.colorGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        // ))
        ;
  }
}
