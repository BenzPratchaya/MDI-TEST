// ignore_for_file: unnecessary_null_comparison
import 'package:envision6mdi/pages/mdi/mdi_report_data/mdi_report_data.dart';
import 'package:envision6mdi/pages/mdi/mdi_worklist/mdi_worklist_page.dart';
import 'package:flutter/material.dart';

import '../pages/config_page/config_page.dart';
import '../pages/config_page/location_setup/location_setup_page.dart';
import '../pages/config_page/modality_setup/modality_setup_page.dart';
import '../pages/config_page/sub_location_setup/sub_location_setup_page.dart';
import '../pages/login/login_operator_page.dart';
import '../pages/login/login_page.dart';
import 'route_name.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name!);

  switch (uri.path.toLowerCase()) {
    case logInRoute:
      return getPageRoute(const LoginPage(), settings);
    case homeRoute:
      return getPageRoute(const MDIWorklistPage(), settings);
    case mdiInsertPageRoute:
      var modalityUid = uri.queryParameters.containsKey('modalityuid')
          ? uri.queryParameters['modalityuid']
          : null;
      return getPageRoute(
          LoginOperatorPage(modalityUid: modalityUid), settings);
    case configRoute:
      return getPageRoute(const ConfigPage(), settings);
    case modalitySetupRoute:
      return getPageRoute(const ModalitySetupPage(), settings);
    case locationSetupRoute:
      return getPageRoute(const LocationSetupPage(), settings);
    case subLocationSetupRoute:
      return getPageRoute(const SubLocationSetupPage(), settings);
    case exportDataRoute:
      return getPageRoute(const MDIReportDataPage(), settings);
    default:
      return getPageRoute(const LoginPage(), settings);
  }
}

PageRoute getPageRoute(Widget child, RouteSettings settings) {
  return FadeRoute(child: child, routeName: settings.name);
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String? routeName;
  FadeRoute({required this.child, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
