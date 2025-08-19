import 'dart:convert';
import 'package:envision6mdi/models/mdi/user_model.dart';
import 'package:envision6mdi/models/response/envision_response_model.dart';
import 'package:envision6mdi/services/user_preferences.dart';
import 'package:flutter/services.dart';

import '../locator.dart';
import '../models/mdi/location_model.dart';
import '../models/mdi/modality_model.dart';
import '../models/mdi/sub_location_model.dart';
import 'api_constants.dart';
import 'api_service.dart';

class MDIService {
  final _api = locator<ApiService>();
  late EnvisionResponseModel _response = EnvisionResponseModel();
  EnvisionResponseModel get response => _response;
  final isMock = false;
  // data view

  //   Future getSelectViewByDateWithLocationId(
  //     DateTime startDate, DateTime endDate, int locationId) async {
  //   var creds = {
  //     'StartDateTime': startDate.toIso8601String(),
  //     'EndDateTime': endDate.toIso8601String(),
  //     'LocationId': locationId
  //   };
  //   dynamic data;
  //   if (isMock) {
  //     data = getDataFromJsonFile('data/mock/SelectViewByDate.json');
  //   } else {
  //     data = await _api.post(
  //         ApiConstants.selectDataViewByDateWithLocationId, creds);
  //   }
  //   return data;
  // }
  Future getSelectDataViewByDateWithModalityId(
      DateTime startDate, DateTime endDate, int modalityId) async {
    var creds = {
      'StartDateTime': startDate.toIso8601String(),
      'EndDateTime': endDate.toIso8601String(),
      'ModalityId': modalityId
    };
    dynamic data;
    data =
        await _api.post(ApiConstants.selectDataViewByDateWithModalityId, creds);
    return data;
  }

  Future getSelectDataViewByDate(
      DateTime startDate, DateTime endDate, int orgId) async {
    var creds = {
      'StartDateTime': startDate.toIso8601String(),
      'EndDateTime': endDate.toIso8601String(),
      'OrganizationId': orgId
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataViewByDate, creds);
    return data;
  }

  Future getSelectDataViewByHn(String hn) async {
    var creds = {
      'Hn': hn,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataViewByHn, creds);
    return data;
  }

  Future getSelectByDateGroupByModality(
      DateTime startDate, DateTime endDate, int orgId) async {
    var creds = {
      'StartDateTime': startDateTime(startDate),
      'EndDateTime': endDateTime(endDate),
      'OrganizationId': orgId
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectByDateGroupByModality, creds);
    return data;
  }

  startDateTime(DateTime startDate) {
    return startDate
        .copyWith(hour: 00, minute: 00, second: 00)
        .toIso8601String();
  }

  endDateTime(DateTime startDate) {
    return startDate
        .copyWith(hour: 23, minute: 59, second: 59)
        .toIso8601String();
  }

  Future getSelectByDataId(int? dataId, int patientVisitId) async {
    var creds = {'DataId': dataId, 'PatientVisitId': patientVisitId};
    dynamic data;
    data = await _api.post(ApiConstants.selectDataById, creds);
    return data;
  }

  Future getSelectDataLogByDataId(int id) async {
    var creds = {
      'DataId': id,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataLogByDataId, creds);
    return data;
  }

  Future getSelectDataNonConfirmByHn(String hn) async {
    var creds = {
      'Hn': hn,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataNonConfirmByHn, creds);
    return data;
  }

  Future getSelectDataNonConfirmByVN(String visitNo) async {
    var creds = {
      'VisitNo': visitNo,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataNonConfirmByVN, creds);
    return data;
  }

  Future getSelectDataLastVisitByHn(String hn) async {
    var creds = {
      'Hn': hn,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectDataLastVisitByHn, creds);
    return data;
  }

  Future getSelectDataNonConfirmByModalityId(int modalityId) async {
    var creds = {
      'ModalityId': modalityId,
    };
    dynamic data;
    data =
        await _api.post(ApiConstants.selectDataNonConfirmByModalityId, creds);
    return data;
  }

  // mdi data
  Future updateByDataId(
      int? pulseRate,
      double? spo2,
      double? temperature,
      int? isComfirmed,
      int? bloodPressureSystolic,
      int? bloodPressureDiastolic,
      int? bloodPressureMean,
      double? respirationRate,
      int? painScale,
      String? comment,
      String? confirmedByUid,
      int modifiedBy,
      int? dataId,
      int patientVisitId,
      int? orgId) async {
    dynamic data;
    if (dataId == null) {
      var creds = {
        'PulseRate': pulseRate,
        'SpO2': spo2,
        'Temperature': temperature,
        'IsConfirmed': isComfirmed,
        'BloodPressureSystolic': bloodPressureSystolic,
        'BloodPressureDiastolic': bloodPressureDiastolic,
        'BloodPressureMean': bloodPressureMean,
        'BloodPressure':
            '$bloodPressureSystolic/$bloodPressureDiastolic($bloodPressureMean)',
        'RespirationRate': respirationRate,
        'PainScale': painScale,
        'Comment': comment,
        'ConfirmedByUid': confirmedByUid,
        'ModifiedBy': modifiedBy,
        'patientVisitId': patientVisitId,
        'OrganizationId': orgId
      };
      data = await _api.post(ApiConstants.insertData, creds);
    } else {
      var creds = {
        'PulseRate': pulseRate,
        'SpO2': spo2,
        'Temperature': temperature,
        'IsConfirmed': isComfirmed,
        'BloodPressureSystolic': bloodPressureSystolic,
        'BloodPressureDiastolic': bloodPressureDiastolic,
        'BloodPressureMean': bloodPressureMean,
        'BloodPressure':
            '$bloodPressureSystolic/$bloodPressureDiastolic($bloodPressureMean)',
        'RespirationRate': respirationRate,
        'PainScale': painScale,
        'Comment': comment,
        'ConfirmedByUid': confirmedByUid,
        'ModifiedBy': modifiedBy,
        'DataId': dataId,
        'patientVisitId': patientVisitId,
        'OrganizationId': orgId
      };
      data = await _api.post(ApiConstants.updateData, creds);
    }

    return data;
  }

  // Patient Visit
  Future updatePatientVisitData(
      double? patientWeight,
      double? patientHeight,
      double? patientBmi,
      int? modifiedBy,
      int? patientVisitId,
      String? patientType,
      int? comaEScore,
      int? comaVScore,
      int? comaMScore,
      String? smokingStatus,
      int? smokingHsi,
      int? cvRiskScore,
      // int? newsScore,
      int? fallRiskType) async {
    var creds = {
      'PatientWeight': patientWeight,
      'PatientHeight': patientHeight,
      'PatientBmi': patientBmi,
      'PatientType': patientType,
      'ComaEScore': comaEScore,
      'ComaVScore': comaVScore,
      'ComaMScore': comaMScore,
      'SmokingStatus': smokingStatus,
      'SmokingHsi': smokingHsi,
      'CvRiskScore': cvRiskScore,
      // 'NewsScore': newsScore,
      'ModifiedBy': modifiedBy,
      'PatientVisitId': patientVisitId,
      'fallRiskType': fallRiskType
    };
    dynamic data;
    data = await _api.post(ApiConstants.updatePatientVisit, creds);
    return data;
  }

  // Future getLocation() async {
  //   dynamic data;
  //   if (isMock) {
  //     data = getDataFromJsonFile('data/mock/location.json');
  //   } else {
  //     // data = await _api.get(ApiConstants.selectViewByDate);
  //   }
  //   return data;
  // }

  Future getUser() async {
    dynamic data;
    if (isMock) {
      data = getDataFromJsonFile('data/mock/USER_DATA.json');
    } else {
      // data = await _api.get(ApiConstants.selectViewByDate);
    }
    return data;
  }

  getDataFromJsonFile(String path) async {
    var response = await rootBundle.loadString(path);
    return json.decode(response);
  }

  //--------------------------------------

  Future getUserByLink() async {
    EnvisionResponseModel response = EnvisionResponseModel();
    User user = User();
    await rootBundle.loadString('data/USER_DATA.json').then(
      (value) {
        if (value != " " && value != "") {
          response = EnvisionResponseModel.fromJson(json.decode(value));
          user = User.fromJson(response.data_1[0]);
          UserPreferences().saveUser(user);
        }
      },
    );
    return user;
  }

  // Modality
  Future getSelectModalityByUid(String modalityUid) async {
    var creds = {
      'modalityUid': modalityUid,
    };
    try {
      var res = await _api.post(ApiConstants.selectModalityByUid, creds);
      _response = EnvisionResponseModel.fromJson(res);
    } catch (e) {
      _response.acknowledgementCode = 'EE';
      _response.textMessage = e.toString();
    }
  }

  Future getModalityView(int orgId) async {
    var creds = {
      'OrganizationId': orgId,
    };
    dynamic data;
    if (isMock) {
      data = getDataFromJsonFile('data/mock/SelectModalityView.json');
    } else {
      data = await _api.post(ApiConstants.selectModalityView, creds);
    }
    return data;
  }

  Future insertModality(Modality modality) async {
    dynamic data;
    var creds = modality.toJson();
    data = await _api.post(ApiConstants.insertModality, creds);
    return data;
  }

  Future updateModality(Modality modality) async {
    dynamic data;
    var creds = modality.toJson();
    data = await _api.post(ApiConstants.updateModality, creds);
    return data;
  }

  // Location
  Future getSelectLocationByUid(String locationUid) async {
    var creds = {
      'LocationUid': locationUid,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectLocationByUid, creds);
    return data;
  }

  Future getSelectLocationView(int organizationId) async {
    var creds = {
      'OrganizationId': organizationId,
    };
    dynamic data;
    if (isMock) {
      data = getDataFromJsonFile('data/mock/SelectLocationView.json');
    } else {
      data = await _api.post(ApiConstants.selectLocationView, creds);
    }
    return data;
  }

  Future updateLocation(Location location) async {
    dynamic data;
    var creds = location.toJson();
    data = await _api.post(ApiConstants.updateLocation, creds);
    return data;
  }

  //SubLocation
  Future getSubLocationView(int organizationId) async {
    var creds = {'OrganizationId': organizationId};
    dynamic data;
    if (isMock) {
      data = getDataFromJsonFile('data/mock/SelectSubLocationView.json');
    } else {
      data = await _api.post(ApiConstants.selectSubLocationView, creds);
    }
    return data;
  }

  Future getSubLocationViewByLocationId(
      int organizationId, int locationId) async {
    var creds = {'OrganizationId': organizationId, 'LocationId': locationId};
    dynamic data;
    if (isMock) {
      data = getDataFromJsonFile('data/mock/SelectSubLocationView.json');
    } else {
      data = await _api.post(
          ApiConstants.selectSubLocationViewByLocationId, creds);
    }
    return data;
  }

  getUpdateDataFrequency() {
    // Map<String, dynamic> data;
    var data = getDataFromJsonFile('data/setting.json');
    return data;
  }

  Future insertSubLocation(SubLocation subLocation) async {
    dynamic data;
    var creds = subLocation.toJson();
    data = await _api.post(ApiConstants.insertSubLocation, creds);
    return data;
  }

  Future updateSubLocation(SubLocation subLocation) async {
    dynamic data;
    var creds = subLocation.toJson();
    data = await _api.post(ApiConstants.updateSubLocation, creds);
    return data;
  }

  // Patient

  Future getSelectPatientByHn(String hn, int orgId) async {
    var creds = {
      'hn': hn,
      'OrganizationId': orgId,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectPatientByHn, creds);
    return data;
  }

  Future getSelectPatientByVN(String vn, int orgId) async {
    var creds = {
      'VisitNo': vn,
      'OrganizationId': orgId,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectPatientByVN, creds);
    return data;
  }

  // Organization
  Future getSelectOrganizationById(int orgId) async {
    var creds = {
      'OrganizationId': orgId,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectOrganizationById, creds);
    return data;
  }

  Future getSelectOrganizationView() async {
    dynamic data;
    data = await _api.post(ApiConstants.selectOrganizationView, '');
    return data;
  }

  Future getSelectOrganizationByUid(String orgUid) async {
    var creds = {
      'OrganizationUid': orgUid,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectOrganizationByUid, creds);
    return data;
  }

  Future insertLocation(Location location) async {
    dynamic data;
    var creds = location.toJson();
    data = await _api.post(ApiConstants.insertLocation, creds);
    return data;
  }

  //General
  Future getSelectGeneralViewByGroup(String generalGroup) async {
    var creds = {
      'GeneralGroup': generalGroup,
    };
    dynamic data;
    data = await _api.post(ApiConstants.selectGeneralViewByGroup, creds);
    return data;
  }

  //Service
  Future setDataToService(int dataId, int orgId) async {
    var creds = {"DataId": dataId, "OrganizationId": orgId};
    dynamic data;
    data = await _api.post(ApiConstants.setData, creds);
    return data;
  }
}
