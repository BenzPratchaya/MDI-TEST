import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import '../pages/login/login_page.dart';
import '../providers/user_provider.dart';
import '../routing/route_name.dart';
import '../services/authentication_service.dart';
import '../services/navigation_service.dart';
import '../services/user_preferences.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationService api = AuthenticationService();
    final user = Provider.of<UserProvider?>(context)!;
// final VnaProvider? vnaProvider;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            // decoration: const BoxDecoration(
            //     color: EnvisionColor.primaryColor,
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage("/images/mdi_logo.png"),
            //     )),
            accountName: Text(
                '${user.user.userTitle ?? ''} ${user.user.userFName ?? ''} ${user.user.userMName ?? ''} ${user.user.userLName ?? ''}'),
            accountEmail: null,
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       "https://randomuser.me/api/portraits/women/74.jpg"),
            // ),
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Worklist'),
            // selected: currentRoute == AppRoutes.records,
            // selected: true,
            onTap: () {
              locator<NavigationService>().navigateTo(homeRoute);
            },
          ),

          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Export Data'),
            // selected: currentRoute == AppRoutes.records,
            // selected: true,
            onTap: () {
              locator<NavigationService>().navigateTo(exportDataRoute);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     locator<NavigationService>().navigateTo(configRoute);
          //   },
          // ),
          if (user.user.userType == 'A' || user.user.userType == 'S')
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                "Settings",
              ),
              leading: const Icon(Icons.settings),
              childrenPadding:
                  const EdgeInsets.only(left: 60), //children padding
              children: [
                // ListTile(
                //   title: const Text("User Setup"),
                //   onTap: () {
                //     locator<NavigationService>().navigateTo(configRoute);
                //   },
                // ),
                ListTile(
                  title: const Text("Modality Setup"),
                  onTap: () {
                    locator<NavigationService>().navigateTo(modalitySetupRoute);
                  },
                ),
                ListTile(
                  title: const Text("Location Setup"),
                  onTap: () {
                    locator<NavigationService>().navigateTo(locationSetupRoute);
                  },
                ),
                ListTile(
                  title: const Text("SubLocation Setup"),
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(subLocationSetupRoute);
                  },
                ),
                // ListTile(
                //   title: const Text("Setting"),
                //   onTap: () {
                //     locator<NavigationService>().navigateTo(configRoute);
                //   },
                // ),
              ],
            ),
          // const Divider(
          //   height: 20,
          //   thickness: 1,
          // ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              api.logOut();
              user.removeUser();
              UserPreferences().removeUser();
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return const LoginPage();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                  (Route route) => false);
            },
          ),
        ],
      ),
    );
  }
}
