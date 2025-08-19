import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/menu_controller.dart';
import '../../helpers/responsive.dart';
import '../../locator.dart';
import '../../routing/route_name.dart';
import '../../routing/router.dart';
import '../../services/navigation_service.dart';
import '../../widgets/navdrawer_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuDrawerController>().scaffoldKey,
      // drawer: Responsive.isDesktop(context) ? null : const NavDrawer(),
      drawer: const NavDrawer(),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: EnvisionColor.colorGreen),
      //   backgroundColor: EnvisionColor.primaryColor,
      //   elevation: 0,
      // title: const Text('ENVISION MDI'),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Row(
      //       // mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         const Text(
      //           'ENVISION MDI',
      //           style: TextStyle(
      //               color: EnvisionColor.secondaryColor,
      //               fontSize: EnvisionSize.largeFontSize),
      //         ),
      //         const SizedBox(width: 20),
      //         Text(
      //           'Medical Device Interface',
      //           style: TextStyle(
      //               color: EnvisionColor.secondaryColor.withOpacity( 0.2),
      //               fontSize: EnvisionSize.defaultFontSize),
      //         ),
      //       ],
      //     ),
      //     OrganizationWidget(
      //         // user: user,
      //         )
      //   ],
      // ),
      // ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: NavDrawer(),
              ),
            Expanded(
              flex: 5,
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: homeRoute,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
