class MdiDataModel {
  int? patientVisitId;
  int? patientId;
  int? locationId;
  int? subLocationId;
  String? visitNo;
  String? patientType;
  int? comaEScore;
  int? comaVScore;
  int? comaMScore;
  String? smokingStatus;
  int? smokingHsi;
  int? cvRiskScore;
  int? mewsScore;
  int? newsScore;
  int? modalityWhId;
  DateTime? whDateTime;
  double? patientWeight;
  double? patientWeightUnit;
  double? patientHeight;
  double? patientHeightUnit;
  double? patientBmi;
  int? organizationId;
  DateTime? createdOn;
  int? createdBy;
  DateTime? modifiedOn;
  int? modifiedBy;

  String? organizationUid;

  int? dataId;

  String? hn;
  String? patientName;
  String? patientGenderText;
  DateTime? patientDob;
  String? patientAgeText;
  String? patientSsn;

  String? patientTypeText;

  String? locationText;

  String? subLocationText;

  String? modalityWhText;

  String? patientWeightText;

  String? patientHeightText;

  int? modalityVsId;
  String? modalityVsText;
  DateTime? vsDateTime;
  String? pulseRateText;
  String? pulseFlagText;
  String? bloodPressureText;
  String? bloodPressureMethod;
  String? spo2Text;
  String? temperatureText;
  String? temperatureMethod;
  double? respirationRate;
  int? painScale;
  String? dataStatus;
  String? dataStatusText;
  int? isConfirmed;
  String? confirmedByUid;
  int? confirmedById;
  String? confirmedByName;
  DateTime? confirmedOn;

  int? pulseRate;
  String? pulseUnit;
  String? pulseFlag;
  int? bloodPressureSystolic;
  int? bloodPressureDiastolic;
  int? bloodPressureMean;
  String? bloodPressure;
  String? bloodPressureUnit;
  double? spo2;
  String? spo2Unit;
  double? temperature;
  String? temperatureUnit;
  String? comment;
  String? comaScore;

  MdiDataModel(
      {this.organizationId,
      this.organizationUid,
      this.patientVisitId,
      this.dataId,
      this.patientId,
      this.hn,
      this.patientName,
      this.patientGenderText,
      this.patientDob,
      this.patientAgeText,
      this.patientSsn,
      this.visitNo,
      this.patientType,
      this.patientTypeText,
      this.locationId,
      this.locationText,
      this.subLocationId,
      this.subLocationText,
      this.modalityWhId,
      this.modalityWhText,
      this.whDateTime,
      this.patientWeightText,
      this.patientWeight,
      this.patientHeightText,
      this.patientHeight,
      this.patientBmi,
      this.modalityVsId,
      this.modalityVsText,
      this.vsDateTime,
      this.pulseRateText,
      this.pulseFlagText,
      this.bloodPressureText,
      this.bloodPressureMethod,
      this.spo2Text,
      this.temperatureText,
      this.temperatureMethod,
      this.respirationRate,
      this.painScale,
      this.dataStatus,
      this.dataStatusText,
      this.isConfirmed,
      this.confirmedByUid,
      this.confirmedById,
      this.confirmedByName,
      this.confirmedOn,
      this.createdOn,
      this.modifiedOn,
      //
      // this.dataId,
      // this.patientVisitId,
      // this.modalityVsId,
      // this.vsDateTime,
      this.pulseRate,
      this.pulseUnit,
      this.pulseFlag,
      this.bloodPressureSystolic,
      this.bloodPressureDiastolic,
      this.bloodPressureMean,
      this.bloodPressure,
      this.bloodPressureUnit,
      // this.bloodPressureMethod,
      this.spo2,
      this.spo2Unit,
      this.temperature,
      this.temperatureUnit,
      this.comaEScore,
      this.comaVScore,
      this.comaMScore,
      this.smokingStatus,
      this.smokingHsi,
      // this.temperatureMethod,
      // this.respirationRate,
      // this.painScale,
      // this.dataStatus,
      this.comment,
      this.cvRiskScore,
      this.comaScore,
      this.mewsScore,
      // this.organizationId
      this.modifiedBy});

  factory MdiDataModel.fromMap(Map data) {
    return MdiDataModel(
      organizationId: data['OrganizationId'],
      organizationUid: data['OrganizationUid'],
      patientVisitId: data['PatientVisitId'],
      dataId: data['DataId'],
      patientId: data['PatientId'],
      hn: data['Hn'],
      patientName: data['PatientName'],
      patientGenderText: data['PatientGenderText'],
      patientDob: data['PatientDob'],
      patientAgeText: data['PatientAgeText'],
      patientSsn: data['PatientSsn'],
      visitNo: data['VisitNo'],
      patientType: data['PatientType'],
      patientTypeText: data['PatientTypeText'],
      locationId: data['LocationId'],
      locationText: data['LocationText'],
      subLocationId: data['SubLocationId'],
      subLocationText: data['SubLocationText'],
      modalityWhId: data['ModalityWhId'],
      modalityWhText: data['ModalityWhText'],
      whDateTime: data['WhDateTime'],
      patientWeightText: data['PatientWeightText'],
      patientWeight: data['PatientWeight'],
      patientHeightText: data['PatientHeightText'],
      patientHeight: data['PatientHeight'],
      patientBmi: data['PatientBmi'],
      modalityVsId: data['ModalityVsId'],
      modalityVsText: data['ModalityVsText'],
      vsDateTime: data['VsDateTime'],
      pulseRateText: data['PulseRateText'],
      pulseFlagText: data['PulseFlagText'],
      bloodPressureText: data['BloodPressureText'],
      bloodPressureMethod: data['BloodPressureMethod'],
      spo2Text: data['Spo2Text'],
      temperatureText: data['TemperatureText'],
      temperatureMethod: data['TemperatureMethod'],
      respirationRate: data['RespirationRate'],
      painScale: data['PainScale'],
      dataStatus: data['DataStatus'],
      dataStatusText: data['DataStatusText'],
      isConfirmed: data['IsConfirmed'],
      confirmedByUid: data['ConfirmedByUid'],
      confirmedById: data['ConfirmedById'],
      confirmedByName: data['ConfirmedByName'],
      confirmedOn: data['ConfirmedOn'],
      createdOn: data['CreatedOn'],
      modifiedOn: data['ModifiedOn'],
      modifiedBy: data['ModifiedBy'],
      pulseRate: data['PulseRate'],
      pulseUnit: data['PulseUnit'],
      pulseFlag: data['PulseFlag'],
      bloodPressureSystolic: data['BloodPressureSystolic'],
      bloodPressureDiastolic: data['BloodPressureDiastolic'],
      bloodPressureMean: data['BloodPressureMean'],
      bloodPressure: data['BloodPressure'],
      bloodPressureUnit: data['BloodPressureUnit'],
      spo2: data['Spo2'],
      spo2Unit: data['Spo2Unit'],
      temperature: data['Temperature'],
      temperatureUnit: data['TemperatureUnit'],
      comaEScore: data['ComaEScore'],
      comaVScore: data['ComaVScore'],
      comaMScore: data['ComaMScore'],
      smokingStatus: data['SmokingStatus'],
      smokingHsi: data['SmokingHsi'],
      comment: data['Comment'],
      cvRiskScore: data['CvRiskScore'],
      comaScore: data['ComaScore'],
      mewsScore: data['MewsScore'],
    );
  }

  factory MdiDataModel.fromFetchMap(
      MdiDataModel data, MdiDataModel dataUpdate) {
    return MdiDataModel(
      organizationId: data.organizationId,
      organizationUid: data.organizationUid,
      patientVisitId: data.patientVisitId,
      dataId: data.dataId,
      patientId: data.patientId,
      hn: data.hn,
      patientName: data.patientName,
      patientGenderText: data.patientGenderText,
      patientDob: data.patientDob,
      patientAgeText: data.patientAgeText,
      patientSsn: data.patientSsn,
      visitNo: data.visitNo,
      patientType: data.patientType,
      patientTypeText: data.patientTypeText,
      locationId: data.locationId,
      locationText: data.locationText,
      subLocationId: data.subLocationId,
      subLocationText: data.subLocationText,
      modalityWhId: data.modalityWhId,
      modalityWhText: data.modalityWhText,
      whDateTime: data.whDateTime,
      patientWeightText: data.patientWeightText,
      patientWeight: dataUpdate.patientWeight,
      patientHeightText: data.patientHeightText,
      patientHeight: dataUpdate.patientHeight,
      patientBmi: dataUpdate.patientBmi,
      modalityVsId: data.modalityVsId,
      modalityVsText: data.modalityVsText,
      vsDateTime: data.vsDateTime,
      pulseRateText: dataUpdate.pulseRateText,
      pulseFlagText: dataUpdate.pulseFlagText,
      bloodPressureText: data.bloodPressureText,
      bloodPressureMethod: data.bloodPressureMethod,
      spo2Text: dataUpdate.spo2Text,
      temperatureText: data.temperatureText,
      temperatureMethod: data.temperatureMethod,
      respirationRate: data.respirationRate,
      painScale: data.painScale,
      dataStatus: data.dataStatus,
      dataStatusText: data.dataStatusText,
      isConfirmed: data.isConfirmed,
      confirmedByUid: data.confirmedByUid,
      confirmedById: data.confirmedById,
      confirmedByName: data.confirmedByName,
      confirmedOn: data.confirmedOn,
      createdOn: data.createdOn,
      modifiedOn: data.modifiedOn,
      modifiedBy: data.modifiedBy,
      pulseRate: dataUpdate.pulseRate,
      pulseUnit: dataUpdate.pulseUnit,
      pulseFlag: dataUpdate.pulseFlag,
      bloodPressureSystolic: dataUpdate.bloodPressureSystolic,
      bloodPressureDiastolic: dataUpdate.bloodPressureDiastolic,
      bloodPressureMean: dataUpdate.bloodPressureMean,
      bloodPressure: dataUpdate.bloodPressure,
      bloodPressureUnit: data.bloodPressureUnit,
      spo2: data.spo2,
      spo2Unit: data.spo2Unit,
      temperature: data.temperature,
      temperatureUnit: data.temperatureUnit,
      comaEScore: data.comaEScore,
      comaVScore: data.comaVScore,
      comaMScore: data.comaMScore,
      smokingStatus: data.smokingStatus,
      smokingHsi: data.smokingHsi,
      comment: data.comment,
      cvRiskScore: data.cvRiskScore,
      comaScore: data.comaScore,
      mewsScore: data.mewsScore,
    );
  }
  MdiDataModel.fromJson(Map<String, dynamic> json)
      : organizationId = json['OrganizationId'],
        organizationUid = json['OrganizationUid'],
        patientVisitId = json['PatientVisitId'],
        dataId = json['DataId'],
        patientId = json['PatientId'],
        hn = json['Hn'],
        patientName = json['PatientName'],
        patientGenderText = json['PatientGenderText'],
        patientDob = json['PatientDob'] != null
            ? DateTime.parse(json['PatientDob'])
            : json['PatientDob'],
        patientAgeText = json['PatientAgeText'],
        patientSsn = json['PatientSsn'],
        visitNo = json['VisitNo'],
        patientType = json['PatientType'],
        patientTypeText = json['PatientTypeText'],
        locationId = json['LocationId'],
        locationText = json['LocationText'],
        subLocationId = json['SubLocationId'],
        subLocationText = json['SubLocationText'],
        modalityWhId = json['ModalityWhId'],
        modalityWhText = json['ModalityWhText'],
        whDateTime = json['WhDateTime'] != null
            ? DateTime.parse(json['WhDateTime'])
            : json['WhDateTime'],
        patientWeightText = json['PatientWeightText'],
        patientWeight = json['PatientWeight'],
        patientHeightText = json['PatientHeightText'],
        patientHeight = json['PatientHeight'],
        patientBmi = json['PatientBmi'],
        modalityVsId = json['ModalityVsId'],
        modalityVsText = json['ModalityVsText'],
        vsDateTime = json['VsDateTime'] != null
            ? DateTime.parse(json['VsDateTime'])
            : json['VsDateTime'],
        pulseRateText = json['PulseRateText'],
        pulseFlagText = json['PulseFlagText'],
        bloodPressureText = json['BloodPressureText'],
        // bloodPressure = json['BloodPressure'],
        bloodPressureMethod = json['BloodPressureMethod'],
        spo2Text = json['Spo2Text'],
        // spo2 = json['Spo2'],
        temperatureText = json['TemperatureText'],
        // temperature = json['Temperature'],
        temperatureMethod = json['TemperatureMethod'],
        respirationRate = json['RespirationRate'],
        painScale = json['PainScale'],
        dataStatus = json['DataStatus'],
        dataStatusText = json['DataStatusText'],
        isConfirmed = json['IsConfirmed'],
        confirmedByUid = json['ConfirmedByUid'],
        confirmedById = json['ConfirmedById'],
        confirmedByName = json['ConfirmedByName'],
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
        //
        //dataId' : data['dataId'],
        //patientVisitId : data['patientVisitId'],
        //modalityVsId : data['modalityVsId'],
        //vsDateTime : data['vsDateTime'],
        pulseRate = json['PulseRate'],
        pulseUnit = json['PulseUnit'],
        pulseFlag = json['PulseFlag'],
        bloodPressureSystolic = json['BloodPressureSystolic'],
        bloodPressureDiastolic = json['BloodPressureDiastolic'],
        bloodPressureMean = json['BloodPressureMean'],
        bloodPressure = json['BloodPressure'],
        bloodPressureUnit = json['BloodPressureUnit'],
        // bloodPressureMethod = json['bloodPressureMethod'],
        spo2 = json['Spo2'],
        spo2Unit = json['Spo2Unit'],
        temperature = json['Temperature'],
        temperatureUnit = json['TemperatureUnit'],
        comaEScore = json['ComaEScore'],
        comaVScore = json['ComaVScore'],
        comaMScore = json['ComaMScore'],
        smokingStatus = json['SmokingStatus'],
        smokingHsi = json['SmokingHsi'],
        //temperatureMethod  = json['temperatureMethod'],
        //respirationRate  = json['respirationRate'],
        //painScale  = json['painScale'],
        //dataStatus  = json['dataStatus'],
        comment = json['Comment'],
        cvRiskScore = json['CvRiskScore'],
        comaScore = json['ComaScore'],
        mewsScore = json['MewsScore']
  // isConfirmed: json['isConfirmed'],
  // organizationId: json['organizationId'],
  ;

  Map<String, dynamic> toJson() => {
        'OrganizationId': organizationId,
        'OrganizationUid': organizationUid,
        'PatientVisitId': patientVisitId,
        'DataId': dataId,
        'PatientId': patientId,
        'Hn': hn,
        'PatientName': patientName,
        'PatientGenderText': patientGenderText,
        'patientDob': patientDob ?? patientDob?.toIso8601String(),
        'PatientAgeText': patientAgeText,
        'PatientSsn': patientSsn,
        'VisitNo': visitNo,
        'PatientType': patientType,
        'PatientTypeText': patientTypeText,
        'LocationId': locationId,
        'LocationText': locationText,
        'SubLocationId': subLocationId,
        'SubLocationText': subLocationText,
        'ModalityWhId': modalityWhId,
        'ModalityWhText': modalityWhText,
        'WhDateTime': whDateTime ?? whDateTime?.toIso8601String(),
        'PatientWeightText': patientWeightText,
        'PatientWeight': patientWeight,
        'PatientHeightText': patientHeightText,
        'PatientHeight': patientHeight,
        'PatientBmi': patientBmi,
        'ModalityVsId': modalityVsId,
        'ModalityVsText': modalityVsText,
        'VsDateTime': vsDateTime ?? vsDateTime?.toIso8601String(),
        'PulseRateText': pulseRateText,
        'PulseFlagText': pulseFlagText,
        'BloodPressureText': bloodPressureText,
        'BloodPressureMethod': bloodPressureMethod,
        'Spo2Text': spo2Text,
        'TemperatureText': temperatureText,
        'TemperatureMethod': temperatureMethod,
        'RespirationRate': respirationRate,
        'PainScale': painScale,
        'DataStatus': dataStatus,
        'DataStatusText': dataStatusText,
        'IsConfirmed': isConfirmed,
        'ConfirmedByUid': confirmedByUid,
        'ConfirmedById': confirmedById,
        'ConfirmedByName': confirmedByName,
        'ConfirmedOn': confirmedOn ?? confirmedOn?.toIso8601String(),
        'CreatedOn': createdOn ?? createdOn?.toIso8601String(),
        'ModifiedOn': modifiedOn ?? modifiedOn?.toIso8601String(),
        'ModifiedBy': modifiedBy,
        //
        // 'DataId': dataId,
        // 'PatientVisitId': patientVisitId,
        // 'ModalityVsId': modalityVsId,
        // 'VsDateTime': vsDateTime,
        'PulseRate': pulseRate,
        'PulseUnit': pulseUnit,
        'PulseFlag': pulseFlag,
        'BloodPressureSystolic': bloodPressureSystolic,
        'BloodPressureDiastolic': bloodPressureDiastolic,
        'BloodPressureMean': bloodPressureMean,
        'BloodPressure': bloodPressure,
        'BloodPressureUnit': bloodPressureUnit,
        // 'BloodPressureMethod': bloodPressureMethod,
        'Spo2': spo2,
        'Spo2Unit': spo2Unit,
        'Temperature': temperature,
        'TemperatureUnit': temperatureUnit,
        'comaEScore': comaEScore,
        'comaVScore': comaVScore,
        'comaMScore': comaMScore,
        'smokingStatus': smokingStatus,
        'smokingHsi': smokingHsi,
        // 'TemperatureMethod': temperatureMethod,
        // 'RespirationRate': respirationRate,
        // 'PainScale': painScale,
        // 'DataStatus': dataStatus,
        'Comment': comment,
        'CvRiskScore': cvRiskScore,
        'ComaScore': comaScore,
        'MewsScore': mewsScore
        // 'IsConfirmed': isConfirmed,
        // 'OrganizationId': organizationId,
      };
}
