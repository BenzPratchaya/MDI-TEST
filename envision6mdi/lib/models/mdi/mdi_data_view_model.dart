class MdiDataViewModel {
  int? orgId;
  int? patientId;
  int? patientVisitId;
  int? locationId;
  String? visitNo;
  double? patientWeight;
  double? patientHeight;
  double? patientBmi;
  String? patientType;
  int? comaEScore;
  int? comaVScore;
  int? comaMScore;
  String? comaEScoreText;
  String? comaVScoreText;
  String? comaMScoreText;
  String? smokingStatus;
  String? smokingStatusText;
  int? smokingHsi;
  int? cvRiskScore;
  int? newsScore;
  int? fallRiskType;
  String? fallRiskTypeText;
  DateTime? whDateTime;
  DateTime? createdOn;
  int? dataId;
  int? pulseRate;
  String? bloodPressure;
  int? bloodPressureSystolic;
  int? bloodPressureDiastolic;
  int? bloodPressureMean;
  double? temperature;
  double? respirationRate;
  double? spO2;
  int? painScale;
  String? comment;
  int? isConfirmed;
  int? confirmedBy;
  String? confirmedByUid;
  String? hn;
  String? patientName;
  DateTime? patientDob;
  String? patientGenderText;
  String? patientTypeText;
  String? patientAgeText;
  String? modalityWhText;
  int? modalityLocationId;
  String? locationText;
  String? subLocationText;
  String? temperatureText;
  String? spo2Text;
  String? patientHeightText;
  String? patientWeightText;
  String? bloodPressureText;
  String? pulseRateText;
  String? dataStatusText;

  DateTime? lastModifiedOn;

  MdiDataViewModel(
      {this.orgId,
      this.patientId,
      this.patientVisitId,
      this.locationId,
      this.visitNo,
      this.patientWeight,
      this.patientHeight,
      this.patientBmi,
      this.patientType,
      this.comaEScore,
      this.comaVScore,
      this.comaMScore,
      this.comaEScoreText,
      this.comaVScoreText,
      this.comaMScoreText,
      this.smokingStatus,
      this.smokingStatusText,
      this.smokingHsi,
      this.cvRiskScore,
      this.newsScore,
      this.fallRiskType,
      this.fallRiskTypeText,
      this.whDateTime,
      this.createdOn,
      this.dataId,
      this.pulseRate,
      this.bloodPressure,
      this.bloodPressureSystolic,
      this.bloodPressureDiastolic,
      this.bloodPressureMean,
      this.temperature,
      this.respirationRate,
      this.spO2,
      this.painScale,
      this.comment,
      this.isConfirmed,
      this.confirmedBy,
      this.confirmedByUid,
      this.hn,
      this.patientName,
      this.patientDob,
      this.patientGenderText,
      this.patientTypeText,
      this.patientAgeText,
      this.modalityWhText,
      this.modalityLocationId,
      this.subLocationText,
      this.temperatureText,
      this.spo2Text,
      this.patientHeightText,
      this.patientWeightText,
      this.bloodPressureText,
      this.pulseRateText,
      this.dataStatusText,
      this.locationText,
      this.lastModifiedOn});

  MdiDataViewModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrganizationId'];
    patientId = json['PatientId'];
    patientVisitId = json['PatientVisitId'];
    locationId = json['LocationId'];
    visitNo = json['VisitNo'];
    patientWeight = json['PatientWeight'];
    patientHeight = json['PatientHeight'];
    patientBmi = json['PatientBmi'];
    patientType = json['PatientType'];
    comaEScore = json['ComaEScore'];
    comaVScore = json['ComaVScore'];
    comaMScore = json['ComaMScore'];
    comaEScoreText = json['ComaEScoreText'];
    comaVScoreText = json['ComaVScoreText'];
    comaMScoreText = json['ComaMScoreText'];
    smokingStatus = json['SmokingStatus'];
    smokingStatusText = json['SmokingStatusText'];
    smokingHsi = json['SmokingHsi'];
    cvRiskScore = json['CvRiskScore'];
    newsScore = json['NewsScore'];
    fallRiskType = json['FallRiskType'];
    fallRiskTypeText = json['FallRiskTypeText'];
    whDateTime = json['WhDateTime'] != null
        ? DateTime.parse(json['WhDateTime'])
        : json['WhDateTime'];
    createdOn = json['CreatedOn'] != null
        ? DateTime.parse(json['CreatedOn'])
        : json['CreatedOn'];
    dataId = json['DataId'];
    pulseRate = json['PulseRate'];
    bloodPressure = json['BloodPressure'];
    bloodPressureSystolic = json['BloodPressureSystolic'];
    bloodPressureDiastolic = json['BloodPressureDiastolic'];
    bloodPressureMean = json['BloodPressureMean'];
    temperature = json['Temperature'];
    respirationRate = json['RespirationRate'];
    spO2 = json['SpO2'];
    painScale = json['PainScale'];
    comment = json['Comment'];
    isConfirmed = json['IsConfirmed'];
    confirmedBy = json['ConfirmedBy'];
    confirmedByUid = json['ConfirmedByUid'];
    hn = json['Hn'];
    patientName = json['PatientName'];
    patientDob = json['PatientDob'] != null
        ? DateTime.parse(json['PatientDob'])
        : json['PatientDob'];
    patientGenderText = json['PatientGenderText'];
    patientTypeText = json['PatientTypeText'];
    patientAgeText = json['PatientAgeText'];
    modalityWhText = json['ModalityWhText'];
    modalityLocationId = json['ModalityLocationId'];
    subLocationText = json['SubLocationText'];
    temperatureText = json['TemperatureText'];
    spo2Text = json['Spo2Text'];
    patientHeightText = json['PatientHeightText'];
    patientWeightText = json['PatientWeightText'];
    bloodPressureText = json['BloodPressureText'];
    pulseRateText = json['PulseRateText'];
    dataStatusText = json['DataStatusText'];
    locationText = json['LocationText'];
    lastModifiedOn = json['LastModifiedOn'] != null
        ? DateTime.parse(json['LastModifiedOn'])
        : json['LastModifiedOn'];
  }
  factory MdiDataViewModel.fetchData(
      MdiDataViewModel data, MdiDataViewModel dataUpdate) {
    return MdiDataViewModel(
      //from web
      respirationRate: data.respirationRate,
      painScale: data.painScale,
      comaEScore: data.comaEScore,
      comaVScore: data.comaVScore,
      comaMScore: data.comaMScore,
      smokingStatus: data.smokingStatus,
      smokingHsi: data.smokingHsi,
      comment: data.comment,
      cvRiskScore: data.cvRiskScore,
      newsScore: data.newsScore,
      fallRiskType: data.fallRiskType,
      spo2Text: data.spo2Text,
      spO2: data.spO2,
      //fetch data
      createdOn: dataUpdate.createdOn,
      patientId: dataUpdate.patientId,
      hn: dataUpdate.hn,
      patientVisitId: dataUpdate.patientVisitId,
      dataId: dataUpdate.dataId,
      locationId: dataUpdate.locationId,
      subLocationText: dataUpdate.subLocationText,
      modalityWhText: dataUpdate.modalityWhText,
      whDateTime: dataUpdate.whDateTime,
      locationText: dataUpdate.locationText,
      visitNo: dataUpdate.visitNo,
      isConfirmed: dataUpdate.isConfirmed,
      confirmedByUid: dataUpdate.confirmedByUid,
      patientName: dataUpdate.patientName,
      patientGenderText: dataUpdate.patientGenderText,
      patientAgeText: dataUpdate.patientAgeText,
      patientWeightText: dataUpdate.patientWeightText,
      patientHeightText: dataUpdate.patientHeightText,
      bloodPressureText: dataUpdate.bloodPressureText,
      temperatureText: dataUpdate.temperatureText,
      dataStatusText: dataUpdate.dataStatusText,
      pulseRate: dataUpdate.pulseRate ?? data.pulseRate,
      temperature: data.temperature ?? dataUpdate.temperature,
      pulseRateText: dataUpdate.pulseRateText,
      bloodPressure: dataUpdate.bloodPressure,
      patientDob: dataUpdate.patientDob,
      lastModifiedOn: dataUpdate.lastModifiedOn,
      //if don't have data from machine
      patientType: dataUpdate.patientType ?? data.patientType,
      patientTypeText: dataUpdate.patientTypeText,
      patientWeight: dataUpdate.patientWeight ?? data.patientWeight,
      patientHeight: dataUpdate.patientHeight ?? data.patientHeight,
      patientBmi: dataUpdate.patientBmi ?? data.patientBmi,
      bloodPressureSystolic:
          dataUpdate.bloodPressureSystolic ?? data.bloodPressureSystolic,
      bloodPressureDiastolic:
          dataUpdate.bloodPressureDiastolic ?? data.bloodPressureDiastolic,
      bloodPressureMean: dataUpdate.bloodPressureMean ?? data.bloodPressureMean,
      orgId: dataUpdate.orgId ?? data.orgId,
    );
  }

  factory MdiDataViewModel.fetchDataByHn(
      MdiDataViewModel data, MdiDataViewModel dataUpdate) {
    return MdiDataViewModel(
      //from web
      respirationRate: data.respirationRate,
      painScale: data.painScale,
      comaEScore: data.comaEScore,
      comaVScore: data.comaVScore,
      comaMScore: data.comaMScore,
      smokingStatus: data.smokingStatus,
      smokingHsi: data.smokingHsi,
      comment: data.comment,
      cvRiskScore: data.cvRiskScore,
      newsScore: data.newsScore,
      fallRiskType: data.fallRiskType,
      hn: data.hn,
      patientId: data.patientId,
      patientName: data.patientName,
      patientGenderText: data.patientGenderText,
      patientAgeText: data.patientAgeText,
      patientDob: data.patientDob,
      spo2Text: data.spo2Text,
      spO2: data.spO2,
      //fetch data
      createdOn: dataUpdate.createdOn,
      patientVisitId: dataUpdate.patientVisitId,
      dataId: dataUpdate.dataId,
      locationId: dataUpdate.locationId,
      subLocationText: dataUpdate.subLocationText,
      modalityWhText: dataUpdate.modalityWhText,
      whDateTime: dataUpdate.whDateTime,
      locationText: dataUpdate.locationText,
      visitNo: dataUpdate.visitNo,
      isConfirmed: dataUpdate.isConfirmed,
      confirmedByUid: dataUpdate.confirmedByUid,
      patientWeightText: dataUpdate.patientWeightText,
      patientHeightText: dataUpdate.patientHeightText,
      bloodPressureText: dataUpdate.bloodPressureText,
      temperatureText: dataUpdate.temperatureText,
      dataStatusText: dataUpdate.dataStatusText,
      pulseRate: dataUpdate.pulseRate,
      temperature: dataUpdate.temperature ?? data.temperature,
      pulseRateText: dataUpdate.pulseRateText,
      bloodPressure: dataUpdate.bloodPressure,
      lastModifiedOn: dataUpdate.lastModifiedOn,
      //fetch if don't have data from machine
      patientType: dataUpdate.patientType ?? data.patientType,
      patientTypeText: dataUpdate.patientTypeText,
      patientWeight: dataUpdate.patientWeight ?? data.patientWeight,
      patientHeight: dataUpdate.patientHeight ?? data.patientHeight,
      patientBmi: dataUpdate.patientBmi ?? data.patientBmi,
      bloodPressureSystolic:
          dataUpdate.bloodPressureSystolic ?? data.bloodPressureSystolic,
      bloodPressureDiastolic:
          dataUpdate.bloodPressureDiastolic ?? data.bloodPressureDiastolic,
      bloodPressureMean: dataUpdate.bloodPressureMean ?? data.bloodPressureMean,
      orgId: dataUpdate.orgId ?? data.orgId,
    );
  }

  // factory MdiDataViewModel.fetchDataFromMachine(
  //     MdiDataViewModel data, MdiDataViewModel dataUpdate) {
  //   return MdiDataViewModel(
  //     patientId: data.patientId,
  //     dataId: data.dataId,
  //     patientVisitId: data.patientVisitId,
  //     respirationRate: data.respirationRate,
  //     painScale: data.painScale,

  //     comaEScore: data.comaEScore,
  //     comaVScore: data.comaVScore,
  //     comaMScore: data.comaMScore,
  //     smokingStatus: data.smokingStatus,
  //     smokingHsi: data.smokingHsi,
  //     comment: data.comment,
  //     cvRiskScore: data.cvRiskScore,
  //     newsScore: data.newsScore,
  //     fallRiskType: data.fallRiskType,
  //     //fetch data
  //     createdOn: dataUpdate.createdOn,
  //     hn: dataUpdate.hn,
  //     locationId: dataUpdate.locationId,
  //     subLocationText: dataUpdate.subLocationText,
  //     modalityWhText: dataUpdate.modalityWhText,
  //     whDateTime: dataUpdate.whDateTime,
  //     locationText: dataUpdate.locationText,
  //     visitNo: dataUpdate.visitNo,
  //     isConfirmed: dataUpdate.isConfirmed,
  //     confirmedByUid: dataUpdate.confirmedByUid,
  //     patientName: dataUpdate.patientName,
  //     patientGenderText: dataUpdate.patientGenderText,
  //     patientAgeText: dataUpdate.patientAgeText,
  //     patientType: dataUpdate.patientType,
  //     patientTypeText: dataUpdate.patientTypeText,
  //     patientWeight: dataUpdate.patientWeight,
  //     patientHeight: dataUpdate.patientHeight,
  //     patientWeightText: dataUpdate.patientWeightText,
  //     patientHeightText: dataUpdate.patientHeightText,
  //     bloodPressureText: dataUpdate.bloodPressureText,
  //     temperatureText: dataUpdate.temperatureText,
  //     dataStatusText: dataUpdate.dataStatusText,
  //     patientBmi: dataUpdate.patientBmi,
  //     pulseRate: dataUpdate.pulseRate,
  //     temperature: data.temperature ?? dataUpdate.temperature,
  //     pulseRateText: dataUpdate.pulseRateText,
  //     spo2Text: dataUpdate.spo2Text,
  //     spO2: dataUpdate.spO2,
  //     bloodPressureSystolic: dataUpdate.bloodPressureSystolic,
  //     bloodPressureDiastolic: dataUpdate.bloodPressureDiastolic,
  //     bloodPressureMean: dataUpdate.bloodPressureMean,
  //     bloodPressure: dataUpdate.bloodPressure,
  //     lastModifiedOn: dataUpdate.lastModifiedOn,
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = orgId;
    data['PatientId'] = patientId;
    data['PatientVisitId'] = patientVisitId;
    data['LocationId'] = locationId;
    data['VisitNo'] = visitNo;
    data['PatientWeight'] = patientWeight;
    data['PatientHeight'] = patientHeight;
    data['PatientBmi'] = patientBmi;
    data['PatientType'] = patientType;
    data['ComaEScore'] = comaEScore;
    data['ComaVScore'] = comaVScore;
    data['ComaMScore'] = comaMScore;
    data['ComaEScoreText'] = comaEScoreText;
    data['ComaVScoreText'] = comaVScoreText;
    data['ComaMScoreText'] = comaMScoreText;
    data['SmokingStatus'] = smokingStatus;
    data['SmokingStatusText'] = smokingStatusText;
    data['SmokingHsi'] = smokingHsi;
    data['CvRiskScore'] = cvRiskScore;
    data['NewsScore'] = newsScore;
    data['FallRiskType'] = fallRiskType;
    data['FallRiskTypeText'] = fallRiskTypeText;
    data['WhDateTime'] = whDateTime ?? whDateTime?.toIso8601String();
    data['CreatedOn'] = createdOn ?? createdOn?.toIso8601String();
    data['DataId'] = dataId;
    data['PulseRate'] = pulseRate;
    data['BloodPressure'] = bloodPressure;
    data['BloodPressureSystolic'] = bloodPressureSystolic;
    data['BloodPressureDiastolic'] = bloodPressureDiastolic;
    data['BloodPressureMean'] = bloodPressureMean;
    data['Temperature'] = temperature;
    data['RespirationRate'] = respirationRate;
    data['SpO2'] = spO2;
    data['PainScale'] = painScale;
    data['Comment'] = comment;
    data['IsConfirmed'] = isConfirmed;
    data['ConfirmedBy'] = confirmedBy;
    data['ConfirmedByUid'] = confirmedByUid;
    data['Hn'] = hn;
    data['PatientName'] = patientName;
    data['patientDob'] = patientDob ?? patientDob?.toIso8601String();
    data['PatientGenderText'] = patientGenderText;
    data['PatientTypeText'] = patientTypeText;
    data['PatientAgeText'] = patientAgeText;
    data['ModalityWhText'] = modalityWhText;
    data['ModalityLocationId'] = modalityLocationId;
    data['SubLocationText'] = subLocationText;
    data['TemperatureText'] = temperatureText;
    data['Spo2Text'] = spo2Text;
    data['PatientHeightText'] = patientHeightText;
    data['PatientWeightText'] = patientWeightText;
    data['BloodPressureText'] = bloodPressureText;
    data['PulseRateText'] = pulseRateText;
    data['DataStatusText'] = dataStatusText;
    data['LocationText'] = locationText;
    data['LastModifiedOn'] = lastModifiedOn;
    return data;
  }
}
