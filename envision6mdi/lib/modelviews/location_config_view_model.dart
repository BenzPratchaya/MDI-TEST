import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/mdi/location_model.dart';
import '../models/mdi/organization_model.dart';
import '../models/mdi/user_model.dart';
import '../models/response/envision_response_model.dart';
import '../services/mdi_service.dart';

class LocationConfigViewModel extends ChangeNotifier {
  final _api = locator<MDIService>();
  final List<User> _userList = [];
  List<User> get userList => _userList;

  late int _userId;
  int get userId => _userId;

  final List<Location> _locationList = [];
  List<Location> get locationList => _locationList;

  late Location _location;
  Location get location => _location;

  final List<Organization> _organizationList = [];
  List<Organization> get organizationList => _organizationList;

  late int _organizationId = 1;
  int get organizationId => _organizationId;

  late EnvisionResponseModel response;

  prepareLocationData(int orgId, int userId) {
    _organizationId = orgId;
    _userId = userId;
    notifyListeners();
    getOrganizationSelectView();
    getSelectLocationView();
  }

  Future prepareLocationEdit(Location location) async {
    setLocationData(location);
    await getOrganizationSelectView();
  }

  setLocationData(Location location) {
    _location = location;
    _location.organizationId ??= _organizationId;
    _location.modifiedBy ??= _userId;
    notifyListeners();
  }

  Future getOrganizationSelectView() async {
    await _api.getSelectOrganizationView().then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _organizationList.clear();
        if (response.organization_1 != null) {
          for (var e in response.organization_1) {
            _organizationList.add(Organization.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  Future insertLocation() async {
    EnvisionResponseModel res = EnvisionResponseModel();
    res.acknowledgementCode = 'EE';
    res.textMessage = 'error please contact support';
    await _api.insertLocation(_location).then((value) {
      res = EnvisionResponseModel.fromJson(value);
      return res;
    });
    return res;
  }

  Future<EnvisionResponseModel> updateLocation() async {
    EnvisionResponseModel res = EnvisionResponseModel();
    res.acknowledgementCode = 'EE';
    res.textMessage = 'error please contact support';
    await _api.updateLocation(_location).then((value) {
      res = EnvisionResponseModel.fromJson(value);
      return res;
    });
    return res;
  }

  Future getSelectLocationView() async {
    await _api.getSelectLocationView(_organizationId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _locationList.clear();
        if (response.location_1 != null) {
          for (var e in response.location_1) {
            _locationList.add(Location.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  Future getSelectUser() async {
    await _api.getUser().then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _userList.clear();
        if (response.user_1 != null) {
          for (var e in response.user_1) {
            _userList.add(User.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }
}
