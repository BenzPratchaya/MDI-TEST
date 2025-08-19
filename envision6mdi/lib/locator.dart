import 'package:envision6mdi/services/mdi_service.dart';
import 'package:get_it/get_it.dart';

import 'services/api_service.dart';
import 'services/authentication_service.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => MDIService());
}
