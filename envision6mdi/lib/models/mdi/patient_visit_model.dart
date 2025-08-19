class PatientVisit {
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

  PatientVisit(
      {this.organizationId,
      this.patientVisitId,
      this.patientId,
      this.visitNo,
      this.patientType,
      this.locationId,
      this.subLocationId,
      this.modalityWhId,
      this.whDateTime,
      this.patientWeight,
      this.patientHeight,
      this.patientBmi,
      this.createdOn,
      this.modifiedOn,
      this.comaEScore,
      this.comaVScore,
      this.comaMScore,
      this.smokingStatus,
      this.smokingHsi,
      this.cvRiskScore,
      this.mewsScore,
      this.newsScore,
      this.modifiedBy});

  factory PatientVisit.fromMap(Map data) {
    return PatientVisit(
      organizationId: data['OrganizationId'],
      patientVisitId: data['PatientVisitId'],
      patientId: data['PatientId'],
      visitNo: data['VisitNo'],
      patientType: data['PatientType'],
      locationId: data['LocationId'],
      subLocationId: data['SubLocationId'],
      modalityWhId: data['ModalityWhId'],
      whDateTime: data['WhDateTime'],
      patientWeight: data['PatientWeight'],
      patientHeight: data['PatientHeight'],
      patientBmi: data['PatientBmi'],
      createdOn: data['CreatedOn'],
      modifiedOn: data['ModifiedOn'],
      modifiedBy: data['ModifiedBy'],
      comaEScore: data['ComaEScore'],
      comaVScore: data['ComaVScore'],
      comaMScore: data['ComaMScore'],
      smokingStatus: data['SmokingStatus'],
      smokingHsi: data['SmokingHsi'],
      cvRiskScore: data['CvRiskScore'],
      mewsScore: data['MewsScore'],
      newsScore: data['NewsScore'],
    );
  }

  factory PatientVisit.fromFetchMap(
      PatientVisit data, PatientVisit dataUpdate) {
    return PatientVisit(
      organizationId: data.organizationId,
      patientVisitId: data.patientVisitId,
      patientId: data.patientId,
      visitNo: data.visitNo,
      patientType: data.patientType,
      locationId: data.locationId,
      subLocationId: data.subLocationId,
      modalityWhId: data.modalityWhId,
      whDateTime: data.whDateTime,
      patientWeight: dataUpdate.patientWeight,
      patientHeight: dataUpdate.patientHeight,
      patientBmi: dataUpdate.patientBmi,
      createdOn: data.createdOn,
      modifiedOn: data.modifiedOn,
      modifiedBy: data.modifiedBy,
      comaEScore: data.comaEScore,
      comaVScore: data.comaVScore,
      comaMScore: data.comaMScore,
      smokingStatus: data.smokingStatus,
      smokingHsi: data.smokingHsi,
      cvRiskScore: data.cvRiskScore,
      mewsScore: data.mewsScore,
      newsScore: data.newsScore,
    );
  }
  PatientVisit.fromJson(Map<String, dynamic> json)
      : organizationId = json['OrganizationId'],
        patientVisitId = json['PatientVisitId'],
        patientId = json['PatientId'],
        visitNo = json['VisitNo'],
        patientType = json['PatientType'],
        locationId = json['LocationId'],
        subLocationId = json['SubLocationId'],
        modalityWhId = json['ModalityWhId'],
        whDateTime = json['WhDateTime'] != null
            ? DateTime.parse(json['WhDateTime'])
            : json['WhDateTime'],
        patientWeight = json['PatientWeight'],
        patientHeight = json['PatientHeight'],
        patientBmi = json['PatientBmi'],
        createdOn = json['CreatedOn'] != null
            ? DateTime.parse(json['CreatedOn'])
            : json['CreatedOn'],
        modifiedOn = json['ModifiedOn'] != null
            ? DateTime.parse(json['ModifiedOn'])
            : json['ModifiedOn'],
        modifiedBy = json['ModifiedBy'],
        comaEScore = json['ComaEScore'],
        comaVScore = json['ComaVScore'],
        comaMScore = json['ComaMScore'],
        smokingStatus = json['SmokingStatus'],
        smokingHsi = json['SmokingHsi'],
        cvRiskScore = json['CvRiskScore'],
        mewsScore = json['MewsScore'],
        newsScore = json['NewsScore'];

  Map<String, dynamic> toJson() => {
        'OrganizationId': organizationId,
        'PatientVisitId': patientVisitId,
        'PatientId': patientId,
        'VisitNo': visitNo,
        'PatientType': patientType,
        'LocationId': locationId,
        'SubLocationId': subLocationId,
        'ModalityWhId': modalityWhId,
        'WhDateTime': whDateTime ?? whDateTime?.toIso8601String(),
        'PatientWeight': patientWeight,
        'PatientHeight': patientHeight,
        'PatientBmi': patientBmi,
        'CreatedOn': createdOn ?? createdOn?.toIso8601String(),
        'ModifiedOn': modifiedOn ?? modifiedOn?.toIso8601String(),
        'ModifiedBy': modifiedBy,
        'comaEScore': comaEScore,
        'comaVScore': comaVScore,
        'comaMScore': comaMScore,
        'smokingStatus': smokingStatus,
        'smokingHsi': smokingHsi,
        'CvRiskScore': cvRiskScore,
        'MewsScore': mewsScore,
        'NewsScore': newsScore
      };
}
