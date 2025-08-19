class MdiDataModel {
  int? dataId;
  int? patientVisitId;
  int? modalityVsId;
  DateTime? vsDateTime;
  int? pulseRate;
  String? pulseFlag;
  int? bloodPressureSystolic;
  int? bloodPressureDiastolic;
  int? bloodPressureMean;
  String? bloodPressure;
  String? bloodPressureUnit;
  double? spO2;
  String? spO2Unit;
  double? temperature;
  String? temperatureUnit;
  double? respirationRate;
  int? painScale;
  String? dataStatus;
  String? comment;
  int? isConfirmed;
  int? confirmedBy;
  String? confirmedByUid;
  DateTime? confirmedOn;
  int? organizationId;
  DateTime? createdOn;
  int? createdBy;
  DateTime? modifiedOn;
  int? modifiedBy;

  MdiDataModel(
      {this.organizationId,
      this.patientVisitId,
      this.dataId,
      this.modalityVsId,
      this.vsDateTime,
      this.respirationRate,
      this.painScale,
      this.dataStatus,
      this.isConfirmed,
      this.confirmedByUid,
      this.confirmedOn,
      this.createdOn,
      this.modifiedOn,
      this.pulseRate,
      this.pulseFlag,
      this.bloodPressureSystolic,
      this.bloodPressureDiastolic,
      this.bloodPressureMean,
      this.bloodPressure,
      this.bloodPressureUnit,
      this.temperature,
      this.temperatureUnit,
      this.comment,
      this.modifiedBy});

  factory MdiDataModel.fromMap(Map data) {
    return MdiDataModel(
      organizationId: data['OrganizationId'],
      patientVisitId: data['PatientVisitId'],
      dataId: data['DataId'],
      modalityVsId: data['ModalityVsId'],
      vsDateTime: data['VsDateTime'],
      respirationRate: data['RespirationRate'],
      painScale: data['PainScale'],
      dataStatus: data['DataStatus'],
      isConfirmed: data['IsConfirmed'],
      confirmedByUid: data['ConfirmedByUid'],
      confirmedOn: data['ConfirmedOn'],
      createdOn: data['CreatedOn'],
      modifiedOn: data['ModifiedOn'],
      modifiedBy: data['ModifiedBy'],
      pulseRate: data['PulseRate'],
      pulseFlag: data['PulseFlag'],
      bloodPressureSystolic: data['BloodPressureSystolic'],
      bloodPressureDiastolic: data['BloodPressureDiastolic'],
      bloodPressureMean: data['BloodPressureMean'],
      bloodPressure: data['BloodPressure'],
      bloodPressureUnit: data['BloodPressureUnit'],
      temperature: data['Temperature'],
      temperatureUnit: data['TemperatureUnit'],
      comment: data['Comment'],
    );
  }

  factory MdiDataModel.fromFetchMap(
      MdiDataModel data, MdiDataModel dataUpdate) {
    return MdiDataModel(
      organizationId: data.organizationId,
      patientVisitId: data.patientVisitId,
      dataId: data.dataId,
      modalityVsId: data.modalityVsId,
      vsDateTime: data.vsDateTime,
      respirationRate: data.respirationRate,
      painScale: data.painScale,
      dataStatus: data.dataStatus,
      isConfirmed: data.isConfirmed,
      confirmedByUid: data.confirmedByUid,
      confirmedOn: data.confirmedOn,
      createdOn: data.createdOn,
      modifiedOn: data.modifiedOn,
      modifiedBy: data.modifiedBy,
      pulseRate: dataUpdate.pulseRate,
      pulseFlag: dataUpdate.pulseFlag,
      bloodPressureSystolic: dataUpdate.bloodPressureSystolic,
      bloodPressureDiastolic: dataUpdate.bloodPressureDiastolic,
      bloodPressureMean: dataUpdate.bloodPressureMean,
      bloodPressure: dataUpdate.bloodPressure,
      bloodPressureUnit: data.bloodPressureUnit,
      temperature: data.temperature,
      temperatureUnit: data.temperatureUnit,
      comment: data.comment,
    );
  }
  MdiDataModel.fromJson(Map<String, dynamic> json)
      : organizationId = json['OrganizationId'],
        patientVisitId = json['PatientVisitId'],
        dataId = json['DataId'],
        modalityVsId = json['ModalityVsId'],
        vsDateTime = json['VsDateTime'] != null
            ? DateTime.parse(json['VsDateTime'])
            : json['VsDateTime'],
        respirationRate = json['RespirationRate'],
        painScale = json['PainScale'],
        dataStatus = json['DataStatus'],
        isConfirmed = json['IsConfirmed'],
        confirmedByUid = json['ConfirmedByUid'],
        confirmedOn = json['ConfirmedOn'] != null
            ? DateTime.parse(json['ConfirmedOn'])
            : json['ConfirmedOn'],
        createdOn = json['CreatedOn'] != null
            ? DateTime.parse(json['CreatedOn'])
            : json['CreatedOn'],
        modifiedOn = json['ModifiedOn'] != null
            ? DateTime.parse(json['ModifiedOn'])
            : json['ModifiedOn'],
        modifiedBy = json['ModifiedBy'],
        pulseRate = json['PulseRate'],
        pulseFlag = json['PulseFlag'],
        bloodPressureSystolic = json['BloodPressureSystolic'],
        bloodPressureDiastolic = json['BloodPressureDiastolic'],
        bloodPressureMean = json['BloodPressureMean'],
        bloodPressure = json['BloodPressure'],
        bloodPressureUnit = json['BloodPressureUnit'],
        temperature = json['Temperature'],
        temperatureUnit = json['TemperatureUnit'],
        comment = json['Comment'];

  Map<String, dynamic> toJson() => {
        'OrganizationId': organizationId,
        'PatientVisitId': patientVisitId,
        'DataId': dataId,
        'ModalityVsId': modalityVsId,
        'VsDateTime': vsDateTime ?? vsDateTime?.toIso8601String(),
        'RespirationRate': respirationRate,
        'PainScale': painScale,
        'DataStatus': dataStatus,
        'IsConfirmed': isConfirmed,
        'ConfirmedByUid': confirmedByUid,
        'ConfirmedOn': confirmedOn ?? confirmedOn?.toIso8601String(),
        'CreatedOn': createdOn ?? createdOn?.toIso8601String(),
        'ModifiedOn': modifiedOn ?? modifiedOn?.toIso8601String(),
        'ModifiedBy': modifiedBy,
        'PulseRate': pulseRate,
        'PulseFlag': pulseFlag,
        'BloodPressureSystolic': bloodPressureSystolic,
        'BloodPressureDiastolic': bloodPressureDiastolic,
        'BloodPressureMean': bloodPressureMean,
        'BloodPressure': bloodPressure,
        'BloodPressureUnit': bloodPressureUnit,
        'Temperature': temperature,
        'TemperatureUnit': temperatureUnit,
        'Comment': comment,
      };
}
