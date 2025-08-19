import 'package:envision6mdi/models/mdi/gbl_general_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_group_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_log_model.dart';
import 'package:envision6mdi/models/mdi/mdi_data_view_model.dart';
import 'package:envision6mdi/models/mdi/modality_model.dart';
import 'package:envision6mdi/models/mdi/patient_model.dart';
import 'package:envision6mdi/models/mdi/sub_location_model.dart';
import 'package:envision6mdi/models/mdi/user_model.dart';
import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/mdi/location_model.dart';
import '../models/mdi/organization_model.dart';
import '../models/response/envision_response_model.dart';
import '../services/mdi_service.dart';

class MdiViewModel extends ChangeNotifier {
  final _api = locator<MDIService>();

  late EnvisionResponseModel response;
  final List<MdiDataViewModel> _worklist = [];
  List<MdiDataViewModel> get worklist => _worklist;

  final List<MdiDataGroupByModality> _datalistGroupByModality = [];
  List<MdiDataGroupByModality> get datalistGroupByModality =>
      _datalistGroupByModality;
  final List<Location> _locationList = [];
  List<Location> get locationList => _locationList;
  late Location _location = Location();
  Location get location => _location;
  late Modality _modality = Modality();
  Modality get modality => _modality;

  late Organization _organization = Organization();
  Organization get organization => _organization;
  final List<Organization> _organizationList = [];
  List<Organization> get organizationList => _organizationList;

  final List<GblGeneralModel> _patTypeList = [];
  List<GblGeneralModel> get patTypeList => _patTypeList;
  final List<GblGeneralModel> _smokeStatusList = [];
  List<GblGeneralModel> get smokeStatusList => _smokeStatusList;
  final List<GblGeneralModel> _comaEScore = [];
  List<GblGeneralModel> get comaEScore => _comaEScore;
  final List<GblGeneralModel> _comaVScore = [];
  List<GblGeneralModel> get comaVScore => _comaVScore;
  final List<GblGeneralModel> _comaMScore = [];
  List<GblGeneralModel> get comaMScore => _comaMScore;
  final List<GblGeneralModel> _fallRiskTypeList = [];
  List<GblGeneralModel> get fallRiskTypeList => _fallRiskTypeList;

  late MdiDataViewModel _data = MdiDataViewModel();
  MdiDataViewModel get data => _data;
  final List<DataLog> _dataDetail = [];
  List<DataLog> get dataDetail => _dataDetail;

  // late int _dataFrequency;
  // int get dataFrequency => _dataFrequency;

  GblGeneralModel? _patTypeSelected;
  GblGeneralModel? get patTypeSelected => _patTypeSelected;
  GblGeneralModel? _smokeStatusSelected;
  GblGeneralModel? get smokeStatusSelected => _smokeStatusSelected;

  // final List<Location> _locationSelectedList = [];
  // List<Location> get locationSelectedList => _locationSelectedList;

  Location? _locationSelected;
  Location? get locationSelected => _locationSelected;

  Patient? _patient;
  Patient? get patient => _patient;

  SubLocation? _subLocationSelected;
  SubLocation? get subLocationSelected => _subLocationSelected;

  Future prepareWorklistData(
      DateTime startDate, DateTime endDate, int orgId) async {
    // _getLocation();
    _getOrganization();
    getPatTypeList();
    getSmorkingStatusList();
    getComaEScoreList();
    getComaVScoreList();
    getComaMScoreList();
    getFallRiskTypeList();
    getSelectViewByDate(startDate, endDate, orgId);
  }

  Future prepareVisitData(String? modalityUid) async {
    if (modalityUid != null) {
      _modality = await getModalityByUid(modalityUid);
      await getOrganizationById(_modality.organizationId ?? 0);
      // await getPatTypeList();
      await getSmorkingStatusList();
      await getComaEScoreList();
      await getComaVScoreList();
      await getComaMScoreList();
      await getFallRiskTypeList();
      // var feq = await _api.getUpdateDataFrequency();
      // _dataFrequency = feq['dataFrequency'] ?? 30;
    }
    notifyListeners();
  }

  Future prepareEditData(int orgId) async {
    await getOrganizationById(orgId);
    // await getPatTypeList();
    await getSmorkingStatusList();
    await getComaEScoreList();
    await getComaVScoreList();
    await getComaMScoreList();
    await getFallRiskTypeList();
  }

  Future getSelectViewByDate(
      DateTime startDate, DateTime endDate, int orgId) async {
    _worklist.clear();
    await _api.getSelectDataViewByDate(startDate, endDate, orgId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        if (response.data_1 != null) {
          for (var e in response.data_1) {
            _worklist.add(MdiDataViewModel.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  Future getSelectByDateGroupByModality(
      DateTime startDate, DateTime endDate, int orgId) async {
    _datalistGroupByModality.clear();
    await _api
        .getSelectByDateGroupByModality(startDate, endDate, orgId)
        .then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        if (response.data_1 != null) {
          for (var e in response.data_1) {
            _datalistGroupByModality.add(MdiDataGroupByModality.fromJson(e));
          }
        }
      }
    });

    notifyListeners();
  }

  Future getSelectDataViewByHn(String hn) async {
    await _api.getSelectDataViewByHn(hn).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _worklist.clear();
        if (response.data_1 != null) {
          for (var e in response.data_1) {
            _worklist.add(MdiDataViewModel.fromJson(e));
          }
        }
      }
    });

    notifyListeners();
  }

  // Future getSelectViewByOrgIdOrLocationId(int? orgId, int? locationId) async {
  //   _worklist.clear();
  //   var today = DateTime.now();
  //   if (locationId != null) {
  //     await _api
  //         .getSelectViewByDateWithLocationId(today, today, locationId)
  //         .then((value) {
  //       response = EnvisionResponseModel.fromJson(value);
  //       if (response.acknowledgementCode == 'AA') {
  //         if (response.data_1 != null) {
  //           for (var e in response.data_1) {
  //             _worklist.add(MdiDataViewModel.fromJson(e));
  //           }
  //         }
  //       }
  //     });
  //   } else if (orgId != null) {
  //     await _api.getSelectViewByDate(today, today, orgId).then((value) {
  //       response = EnvisionResponseModel.fromJson(value);
  //       if (response.acknowledgementCode == 'AA') {
  //         if (response.data_1 != null) {
  //           for (var e in response.data_1) {
  //             _worklist.add(MdiDataViewModel.fromJson(e));
  //           }
  //         }
  //       }
  //     });
  //   }
  //   notifyListeners();
  // }

  Future getSelectViewByModalityId(int? modalityId) async {
    _worklist.clear();
    if (modalityId != null) {
      await _api.getSelectDataNonConfirmByModalityId(modalityId).then((value) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          if (response.data_1 != null) {
            for (var e in response.data_1) {
              _worklist.add(MdiDataViewModel.fromJson(e));
            }
          }
        }
      });
    }
    notifyListeners();
  }

  Future getSelectDataDetail(int id) async {
    await _api.getSelectDataLogByDataId(id).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        _dataDetail.clear();
        if (response.dataLog_1 != null) {
          for (var e in response.dataLog_1) {
            _dataDetail.add(DataLog.fromJson(e));
          }
        }
      }
    });
    notifyListeners();
  }

  // Future getSelectLogByHn(String hn) async {
  //   await _api.getSelectByHn(hn).then((value) {
  //     response = EnvisionResponseModel.fromJson(value);
  //     if (response.acknowledgementCode == 'AA') {
  //       _dataDetail.clear();
  //       if (response.dataLog_1 != null) {
  //         for (var e in response.dataLog_1) {
  //           // DataLog data = DataLog.fromJson(e);
  //           _dataDetail.add(DataLog.fromJson(e));
  //         }
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }

  Future getSelectDataById(int? dataId, int patientVisitId) async {
    _data = MdiDataViewModel();
    await _api.getSelectByDataId(dataId, patientVisitId).then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        if (response.data_1 != null) {
          _data = MdiDataViewModel.fromJson(response.data_1[0]);
        }
      }
    });
    notifyListeners();
  }

  Future getSelectDataNonConfirmByHn(String hn) async {
    var value = await _api.getSelectDataNonConfirmByHn(hn);
    response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      if (response.data_1 != null) {
        _data = MdiDataViewModel.fromJson(response.data_1[0]);
      }
      notifyListeners();
    }
  }

  Future getSelectDataByHn(String hn, int orgId) async {
    _data = MdiDataViewModel();
    // MdiDataViewModel mdiData = MdiDataViewModel();
    Patient pat = Patient();
    var value = await _api.getSelectDataNonConfirmByHn(hn);
    response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      if (response.data_1 != null) {
        _data = MdiDataViewModel.fromJson(response.data_1[0]);
      } else {
        value = await _api.getSelectPatientByHn(hn, orgId);
        response = EnvisionResponseModel.fromJson(value);
        // if (response.acknowledgementCode == 'AA' ||
        //     response.textMessage == "Undefined") {
        if (response.patient_1 != null) {
          pat = Patient.fromJson(response.patient_1[0]);
          _data = MdiDataViewModel(
              hn: pat.hn,
              patientId: pat.patientId,
              patientDob: pat.patientDob,
              patientName: '${pat.patientFName} ${pat.patientLName}',
              isConfirmed: 0);
          var value = await _api.getSelectDataLastVisitByHn(hn);
          response = EnvisionResponseModel.fromJson(value);
          if (response.acknowledgementCode == 'AA') {
            if (response.data_1 != null) {
              var tmp = MdiDataViewModel.fromJson(response.data_1[0]);
              _data = MdiDataViewModel(
                  hn: tmp.hn,
                  patientId: tmp.patientId,
                  patientAgeText: tmp.patientAgeText,
                  // patientBmi: tmp.patientBmi,
                  patientDob: tmp.patientDob,
                  patientGenderText: tmp.patientGenderText,
                  // patientHeight: tmp.patientHeight,
                  patientHeightText: tmp.patientHeightText,
                  // patientWeight: tmp.patientWeight,
                  patientWeightText: tmp.patientWeightText,
                  patientName: tmp.patientName,
                  patientType: tmp.patientType,
                  patientTypeText: tmp.patientTypeText,
                  smokingHsi: tmp.smokingHsi,
                  smokingStatus: tmp.smokingStatus,
                  isConfirmed: 0);
            }
            // }
          }
        }
      }
    }
    notifyListeners();
  }

  Future getSelectDataByVn(String vn, int orgId) async {
    _data = MdiDataViewModel();
    // MdiDataViewModel mdiData = MdiDataViewModel();
    Patient pat = Patient();
    var value = await _api.getSelectDataNonConfirmByVN(vn);
    response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      if (response.data_1 != null) {
        _data = MdiDataViewModel.fromJson(response.data_1[0]);
      } else {
        value = await _api.getSelectPatientByVN(vn, orgId);
        response = EnvisionResponseModel.fromJson(value);
        // if (response.acknowledgementCode == 'AA' ||
        //     response.textMessage == "Undefined") {
        if (response.patient_1 != null) {
          pat = Patient.fromJson(response.patient_1[0]);
          _data = MdiDataViewModel(
              hn: pat.hn,
              patientId: pat.patientId,
              patientDob: pat.patientDob,
              patientName: '${pat.patientFName} ${pat.patientLName}',
              isConfirmed: 0);
        }
      }
    }
    notifyListeners();
  }

  Future getSelectDataByVN(String visitNo, int orgId) async {
    _data = MdiDataViewModel();
    // MdiDataViewModel mdiData = MdiDataViewModel();
    // Patient pat = Patient();
    var value = await _api.getSelectDataNonConfirmByVN(visitNo);
    response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      if (response.data_1 != null) {
        _data = MdiDataViewModel.fromJson(response.data_1[0]);
      } else {
        var value = await _api.getSelectPatientByVN(visitNo, orgId);
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          var pat = Patient.fromJson(response.patient_1[0]);
          _data = MdiDataViewModel(
              hn: pat.hn,
              patientId: pat.patientId,
              patientDob: pat.patientDob,
              patientName: '${pat.patientFName} ${pat.patientLName}',
              isConfirmed: 0,
              visitNo: pat.visitNo);
        }
      }
    }
    notifyListeners();
  }

  Future getSelectPatientByHn(String hn, int orgId) async {
    await _api.getSelectPatientByHn(hn, orgId).then((value) {});
  }

  // Future _getLocation() async {
  //   await _api.getLocation().then((value) {
  //     if (value != null) {
  //       response = EnvisionResponseModel.fromJson(value);
  //       if (response.acknowledgementCode == 'AA') {
  //         _locationList.clear();
  //         if (response.data_1 != null) {
  //           for (var e in response.data_1) {
  //             _locationList.add(Location.fromJson(e));
  //             _locationSelected = Location.fromJson(e);
  //           }
  //         }
  //       }
  //     }
  //   });
  //   notifyListeners();
  // }

  Future _getOrganization() async {
    await _api.getSelectOrganizationView().then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _organizationList.clear();
          if (response.organization_1 != null) {
            for (var e in response.organization_1) {
              _organizationList.add(Organization.fromJson(e));
              // _organizationSelected = Organization.fromJson(e);
            }
          }
        }
      }
    });
    notifyListeners();
  }

  Future getOrganizationByUid(String orgUid) async {
    await _api.getSelectOrganizationByUid(orgUid).then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _organization = Organization();
          if (response.organization_1 != null) {
            for (var e in response.organization_1) {
              _organization = Organization.fromJson(e);
              // _organizationSelected = Organization.fromJson(e);
            }
          }
        }
      }
    });
    notifyListeners();
  }

  Future getOrganizationById(int orgId) async {
    await _api.getSelectOrganizationById(orgId).then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _organization = Organization();
          if (response.organization_1 != null) {
            for (var e in response.organization_1) {
              _organization = Organization.fromJson(e);
              // _organizationSelected = Organization.fromJson(e);
            }
          }
        }
      }
    });
    notifyListeners();
  }

  Future getLocationByUid(String locationUid) async {
    await _api.getSelectLocationByUid(locationUid).then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _location = Location();
          if (response.location_1 != null) {
            for (var e in response.location_1) {
              _location = Location.fromJson(e);
            }
          }
        }
      }
    });
    notifyListeners();
  }

  Future<Modality> getModalityByUid(String modalityUid) async {
    Modality mod = Modality();
    await _api.getSelectModalityByUid(modalityUid).then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          if (response.modality_1 != null) {
            for (var e in response.modality_1) {
              mod = Modality.fromJson(e);
            }
          }
        }
      }
    });
    return mod;
  }

  setData(MdiDataViewModel data) {
    _data = data;
    notifyListeners();
  }

  Future<EnvisionResponseModel> setConfirmData(
      MdiDataViewModel data, int userId) async {
    response = EnvisionResponseModel();
    // await _api
    //     .updateByDataId(data.pulseRate!, data.spo2!, data.temperature!,
    //         data.isConfirmed!, userId, data.dataId!)
    //     .then((value) {
    //   response = EnvisionResponseModel.fromJson(value);
    //   if (response.acknowledgementCode == 'AA') {
    //     // var dataList =
    //     //     _worklist.where((_wl) => _wl.dataId == data.dataId).toList();
    //     var index = _worklist.indexWhere((wl) => wl.dataId == data.dataId);
    //     _worklist[index] = data;
    //     notifyListeners();
    //   }
    // });
    return response;
  }

  Future<EnvisionResponseModel> setEditMdiData(
      MdiDataViewModel data, int userId) async {
    response = EnvisionResponseModel();
    await _api
        .updatePatientVisitData(
            data.patientWeight,
            data.patientHeight,
            data.patientBmi,
            userId,
            data.patientVisitId,
            data.patientType,
            data.comaEScore,
            data.comaVScore,
            data.comaMScore,
            data.smokingStatus,
            data.smokingHsi,
            data.cvRiskScore,
            // data.newsScore,
            data.fallRiskType)
        .then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        // var dataList =
        //     _worklist.where((_wl) => _wl.dataId == data.dataId).toList();
        // var index = _worklist.indexWhere((wl) => wl.dataId == data.dataId);
        // _worklist[index] = data;
      } else {
        notifyListeners();
        return response;
      }
    });
    await _api
        .updateByDataId(
            data.pulseRate,
            data.spO2,
            data.temperature,
            data.isConfirmed,
            data.bloodPressureSystolic,
            data.bloodPressureDiastolic,
            data.bloodPressureMean,
            data.respirationRate,
            data.painScale,
            data.comment,
            data.confirmedByUid,
            userId,
            data.dataId,
            data.patientVisitId!,
            data.orgId!)
        .then((value) {
      response = EnvisionResponseModel.fromJson(value);
      if (response.acknowledgementCode == 'AA') {
        // print('setyData ${data.dataId} ${_organization.organizationId}');
        // _api.setDataToService(data.dataId!, data.orgId!);
      } else {
        notifyListeners();
        return response;
      }
    });
    notifyListeners();
    return response;
  }

  setSelectedLocation(Location val) {
    _locationSelected = val;
    // _locationSelectedList.add(val);
    notifyListeners();
  }

  Future getPatTypeList() async {
    await _api.getSelectGeneralViewByGroup('PATIENT_TYPE').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _patTypeList.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _patTypeList.add(gbl);
              if (gbl.isDefault == 1) {
                _patTypeSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  Future getSmorkingStatusList() async {
    await _api.getSelectGeneralViewByGroup('SMOKING_STATUS').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _smokeStatusList.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _smokeStatusList.add(gbl);
              if (gbl.isDefault == 1) {
                _smokeStatusSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  getComaEScoreList() async {
    await _api.getSelectGeneralViewByGroup('COMA_E_SCALE').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _comaEScore.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _comaEScore.add(gbl);
              if (gbl.isDefault == 1) {
                _smokeStatusSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  getComaVScoreList() async {
    await _api.getSelectGeneralViewByGroup('COMA_V_SCALE').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _comaVScore.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _comaVScore.add(gbl);
              if (gbl.isDefault == 1) {
                _smokeStatusSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  getComaMScoreList() async {
    await _api.getSelectGeneralViewByGroup('COMA_M_SCALE').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _comaMScore.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _comaMScore.add(gbl);
              if (gbl.isDefault == 1) {
                _smokeStatusSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  getFallRiskTypeList() async {
    await _api.getSelectGeneralViewByGroup('FALL_RISK_TYPE').then((value) {
      if (value != null) {
        response = EnvisionResponseModel.fromJson(value);
        if (response.acknowledgementCode == 'AA') {
          _fallRiskTypeList.clear();
          if (response.general_1 != null) {
            for (var e in response.general_1) {
              GblGeneralModel gbl = GblGeneralModel.fromJson(e);
              _fallRiskTypeList.add(gbl);
              if (gbl.isDefault == 1) {
                _smokeStatusSelected = gbl;
              }
            }
          }
        }
      }
    });
    notifyListeners();
  }

  getPatientBySelectSearchPatient(String hn) {}

  Future<User> getUserByLink() async {
    return await _api.getUserByLink();
  }
}
