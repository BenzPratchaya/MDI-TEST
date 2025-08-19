import 'package:flutter/foundation.dart';

import '../models/mdi/organization_model.dart';
import '../models/mdi/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user = User();
  User get user => _user!;

  Organization? _organization;
  Organization get organization => _organization!;

  List<Organization>? _organizationList;
  List<Organization> get organizationList => _organizationList!;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  // Future setOrganization() async {
  //   await AuthenticationService()
  //       .getOrganizationSelectView()
  //       .then((value) => _organizationList = value);
  //   notifyListeners();
  // }

  // void getOrganizationSelectView(){
  //   getSelectOrganizationView()
  // }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  bool checkIfAnyIsNull() {
    return _user == null;
  }
}
