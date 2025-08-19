import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/mdi/location_model.dart';
import '../models/mdi/modality_model.dart';
import '../models/mdi/organization_model.dart';
import '../models/mdi/sub_location_model.dart';
import '../models/response/envision_response_model.dart';
import '../services/mdi_service.dart';

class ModalityConfigViewModel extends ChangeNotifier {
  final _api = locator<MDIService>();
  // final List<User> _userList = [];
  // List<User> get userList => _userList;

  final List<Modality> _modalityList = [];
  List<Modality> get modalityList => _modalityList;

  late Modality _modality;
  Modality get modality => _modality;

  final List<SubLocation> _subLocationList = [];
  List<SubLocation> get subLocationList => _subLocationList;
  late List<SubLocation> _subLocationSelectedList = [];
  List<SubLocation> get subLocationSelectedList => _subLocationSelectedList;
  late SubLocation _subLocation;
  SubLocation get subLocation => _subLocation;

  final List<Location> _locationList = [];
  List<Location> get locationList => _locationList;
  late Location _location;
  Location get location => _location;

  late int _orgId = 1;
  int get orgId => _orgId;
  late int _userId;
  int get userId => _userId;
  final List<Organization> _organizationList = [];
  List<Organization> get organizationList => _organizationList;

  late EnvisionResponseModel response;
  // prepareConfigData() {
  //   getSelectUser();
  // }

  prepareModalityData(int orgId, int userId) {
    _userId = userId;
    _orgId = orgId;
    notifyListeners();
    getOrganizationSelectView();
    getSelectModalityView();
  }

  // prepareSubLocationData(int orgId, int userId) {
  //   _orgId = orgId;
  //   _userId = userId;
  //   notifyListeners();
  //   getOrganizationSelectView();
  //   getSelectSubLocationView();
  // }

  // Future prepareSubLocationEdit(SubLocation subLocation) async {
  //   setSubLocationData(subLocation);
  //   await getSelectLocationView();
  //   await getOrganizationSelectView();
  // }

  Future prepareModalityEdit(Modality modality) async {
    setModalityData(modality);
    await getSelectSubLocationView();
    await getSelectLocationView().then((value) => {
          if (modality.locationId != null)
            {setSubLocationListBylocationId(modality.locationId!)}
        });
    await getOrganizationSelectView();
  }

  setSubLocationListBylocationId(int locationId) {
    _subLocationSelectedList = [];
    _subLocationSelectedList =
        _subLocationList.where((e) => e.locationId == locationId).toList();
    notifyListeners();
  }

  setModalityData(Modality modality) {
    _modality = modality;
    _modality.organizationId ??= _orgId;
    _modality.modifiedBy ??= _userId;
    if (modality.locationId != null) {
      setSubLocationListBylocationId(modality.locationId!);
    }
    notifyListeners();
  }

  // setSubLocationData(SubLocation subLocation) {
  //   _subLocation = subLocation;
  //   _subLocation.organizationId ??= _orgId;
  //   _subLocation.modifiedBy ??= _userId;
  //   notifyListeners();
  // }

  Future getSelectModalityView() async {
    await _api.getModalityView(_orgId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _modalityList.clear();
        if (response.modality_1 != null) {
          for (var e in response.modality_1) {
            _modalityList.add(Modality.fromJson(e));
          }
        }
      }
    });
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

  Future insertModality() async {
    EnvisionResponseModel res = EnvisionResponseModel();
    res.acknowledgementCode = 'EE';
    res.textMessage = 'error please contact support';
    await _api.insertModality(_modality).then((value) {
      res = EnvisionResponseModel.fromJson(value);
      return res;
    });
    return res;
  }

  Future updateModality() async {
    EnvisionResponseModel res = EnvisionResponseModel();
    res.acknowledgementCode = 'EE';
    res.textMessage = 'error please contact support';
    await _api.updateModality(_modality).then((value) {
      res = EnvisionResponseModel.fromJson(value);
      return res;
    });
    return res;
  }

  // Future insertSubLocation() async {
  //   EnvisionResponseModel res = EnvisionResponseModel();
  //   res.acknowledgementCode = 'EE';
  //   res.textMessage = 'error please contact support';
  //   await _api.insertSubLocation(_subLocation).then((value) {
  //     res = EnvisionResponseModel.fromJson(value);
  //     return res;
  //   });
  //   return res;
  // }

  // Future<EnvisionResponseModel> updateSubLocation() async {
  //   EnvisionResponseModel res = EnvisionResponseModel();
  //   res.acknowledgementCode = 'EE';
  //   res.textMessage = 'error please contact support';
  //   await _api.updateSubLocation(_subLocation).then((value) {
  //     res = EnvisionResponseModel.fromJson(value);
  //     return res;
  //   });
  //   return res;
  // }

  Future getSelectSubLocationView() async {
    await _api.getSubLocationView(_orgId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _subLocationList.clear();
        if (response.subLocation_1 != null) {
          for (var e in response.subLocation_1) {
            _subLocationList.add(SubLocation.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  Future getSelectSubLocationViewByLocationId(int locationId) async {
    await _api.getSubLocationViewByLocationId(_orgId, locationId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _subLocationList.clear();
        if (response.subLocation_1 != null) {
          for (var e in response.subLocation_1) {
            _subLocationList.add(SubLocation.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  Future getSelectLocationView() async {
    await _api.getSelectLocationView(_orgId).then((value) {
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

  // Future getSelectUser() async {
  //   await _api.getUser().then((value) {
  //     response = EnvisionResponseModel.fromJson(value);
  //     if (response.acknowledgementCode == 'AA') {
  //       _userList.clear();
  //       if (response.user_1 != null) {
  //         for (var e in response.user_1) {
  //           _userList.add(User.fromJson(e));
  //         }
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }
}
