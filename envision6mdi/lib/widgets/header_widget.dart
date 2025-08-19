import 'package:envision6mdi/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/menu_controller.dart';
import '../helpers/constants.dart';
import '../helpers/responsive.dart';
import '../models/mdi/organization_model.dart';
import '../pages/main/organization_widget.dart';
import '../providers/user_provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
      this.title,
      required this.showSearch,
      this.onSearchChaged,
      required this.onOrgChanged,
      required this.organizationList});

  final String? title;
  final bool showSearch;
  final List<Organization> organizationList;
  final Function(String)? onSearchChaged;
  final Function(Organization) onOrgChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: EnvisionColor.colorGrey,
            ),
            onPressed: context.read<MenuDrawerController>().controlMenu,
          ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title ?? 'ENVISION MDI',
              style: const TextStyle(
                  color: EnvisionColor.secondaryColor,
                  fontSize: EnvisionSize.largeFontSize),
            ),
            const SizedBox(width: 20),
            Text(
              'Medical Device Interface',
              style: TextStyle(
                  color: EnvisionColor.secondaryColor.withOpacity(0.2),
                  fontSize: EnvisionSize.defaultFontSize),
            ),
          ],
        ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        if (showSearch)
          Expanded(
              child: SearchField(
            onChanged: onSearchChaged,
          )),
        OrgCard(
            organizationList: organizationList,
            onHeaderOrgChanged: (Organization value) {
              onOrgChanged(value);
            }),
      ],
    );
  }
}

class OrgCard extends StatelessWidget {
  final List<Organization> organizationList;
  final Function(Organization)? onHeaderOrgChanged;
  const OrgCard({
    super.key,
    required this.organizationList,
    this.onHeaderOrgChanged,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrganizationWidget(
          orgId: user.user.organizationId!,
          organizationList: organizationList,
          onOrgChanged: (Organization value) {
            var u = user.user;
            u.organizationId = value.organizationId;
            user.setUser(u);
            UserPreferences().saveUser(user.user);
            onHeaderOrgChanged!(value);
          },
        )
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChanged});
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(
              color: EnvisionColor.fontHintColor,
            ),
            suffixIcon: const Icon(
              Icons.search,
              size: 18,
              color: EnvisionColor.colorGrey,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                borderSide: const BorderSide(
                    color: EnvisionColor.borderColor,
                    width: 1.0,
                    style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(EnvisionSize.borderRadius),
                borderSide: const BorderSide(
                    color: EnvisionColor.borderColor,
                    width: 1.0,
                    style: BorderStyle.solid)),
            hintText: 'Search'));
  }
}
