class Patient {
  int? patientId;
  String? hn;
  String? patientTitle;
  String? patientFName;
  String? patientMName;
  String? patientLName;
  String? patientTitleEng;
  String? patientFNameEng;
  String? patientMNameEng;
  String? patientLNameEng;
  String? patientGender;
  DateTime? patientDob;
  String? patientSsn;
  String? visitNo;
  int? organizationId;

  Patient(
      {this.patientId,
      this.hn,
      this.patientTitle,
      this.patientFName,
      this.patientMName,
      this.patientLName,
      this.patientTitleEng,
      this.patientFNameEng,
      this.patientMNameEng,
      this.patientLNameEng,
      this.patientGender,
      this.patientDob,
      this.patientSsn,
      this.visitNo,
      this.organizationId});

  factory Patient.fromMap(Map data) {
    return Patient(
        patientId: data['PatientId'],
        hn: data['Hn'],
        patientTitle: data['PatientTitle'],
        patientFName: data['PatientFName'],
        patientMName: data['PatientMName'],
        patientLName: data['PatientLName'],
        patientTitleEng: data['PatientTitleEng'],
        patientFNameEng: data['PatientFNameEng'],
        patientMNameEng: data['PatientMNameEng'],
        patientLNameEng: data['PatientLNameEng'],
        patientGender: data['PatientGender'],
        patientDob: data['PatientDob'],
        patientSsn: data['PatientSsn'],
        visitNo: data['VisitNo'],
        organizationId: data['OrganizationId']);
  }

  Patient.fromJson(Map<String, dynamic> json)
      : patientId = json['PatientId'],
        hn = json['Hn'],
        patientTitle = json['PatientTitle'],
        patientFName = json['PatientFName'],
        patientMName = json['PatientMName'],
        patientLName = json['PatientLName'],
        patientTitleEng = json['PatientTitleEng'],
        patientFNameEng = json['PatientFNameEng'],
        patientMNameEng = json['PatientMNameEng'],
        patientLNameEng = json['PatientLNameEng'],
        patientGender = json['PatientGender'],
        patientDob = json['PatientDob'] != null
            ? DateTime.parse(json['PatientDob'])
            : json['PatientDob'],
        patientSsn = json['PatientSsn'],
        visitNo = json['VisitNo'],
        organizationId = json['OrganizationId'];

  Map<String, Object?> toJson() => {
        'PatientId': patientId,
        'Hn': hn,
        'PatientTitle': patientTitle,
        'PatientFName': patientFName,
        'PatientMName': patientMName,
        'PatientLName': patientLName,
        'PatientTitleEng': patientTitleEng,
        'PatientFNameEng': patientFNameEng,
        'PatientMNameEng': patientMNameEng,
        'PatientLNameEng': patientLNameEng,
        'PatientGender': patientGender,
        'PatientDob': patientDob,
        'PatientSsn': patientSsn,
        'VisitNo': visitNo,
        'OrganizationId': organizationId,
      };
}
