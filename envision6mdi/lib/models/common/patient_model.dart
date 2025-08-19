// ignore_for_file: non_constant_identifier_names

class PatientModel {
  int? Id;
  String? hn;
  String? Title;
  DateTime? RegDt;
  String? Fname;
  String? Mname;
  String? Lname;
  String? TitleEng;
  String? FnameEng;
  String? MnameEng;
  String? LnameEng;
  String? SSN;
  DateTime? DOB;
  int? Age;
  String? Addr1;
  String? Addr2;
  String? Addr3;
  String? Addr4;
  String? Addr5;
  String? Phone1;
  String? Phone2;
  String? Phone3;
  String? Email;
  String? Gender;
  String? MaritalStatus;
  int? OccupationId;
  String? Nationality;
  String? PassportNo;
  String? BloodGroup;
  String? Religion;
  String? PatientType;
  String? BlockPatient;
  String? EmContactPerson;
  String? EmRelation;
  String? EmAddr;
  String? EmPhone;
  String? InsuranceType;
  String? Hl7Format;
  bool? Hl7Send;
  bool? LinkDown;
  String? Allergies;
  bool? IsDeleted;
  bool? IsUpdated;
  Object? Picture;
  String? PictureName;
  bool? IsJohndoe;
  bool? IsPregnant;
  bool? IsForeigner;
  bool? IsVip;
  String? HisHn;
  String? ExtHn;
  int? OrgId;
  int? CreatedBy;
  DateTime? CreatedOn;
  int? LastModifiedBy;
  DateTime? LastModifiedOn;
  Object? Occupation;

  PatientModel(
      {this.Id,
      this.hn,
      this.Title,
      this.RegDt,
      this.Fname,
      this.Mname,
      this.Lname,
      this.TitleEng,
      this.FnameEng,
      this.MnameEng,
      this.LnameEng,
      this.SSN,
      this.DOB,
      this.Age,
      this.Addr1,
      this.Addr2,
      this.Addr3,
      this.Addr4,
      this.Addr5,
      this.Phone1,
      this.Phone2,
      this.Phone3,
      this.Email,
      this.Gender,
      this.MaritalStatus,
      this.OccupationId,
      this.Nationality,
      this.PassportNo,
      this.BloodGroup,
      this.Religion,
      this.PatientType,
      this.BlockPatient,
      this.EmContactPerson,
      this.EmRelation,
      this.EmAddr,
      this.EmPhone,
      this.InsuranceType,
      this.Hl7Format,
      this.Hl7Send,
      this.LinkDown,
      this.Allergies,
      this.IsDeleted,
      this.IsUpdated,
      this.Picture,
      this.PictureName,
      this.IsJohndoe,
      this.IsPregnant,
      this.IsForeigner,
      this.IsVip,
      this.HisHn,
      this.ExtHn,
      this.OrgId,
      this.CreatedBy,
      this.CreatedOn,
      this.LastModifiedBy,
      this.LastModifiedOn,
      this.Occupation});

  factory PatientModel.fromMap(Map data) {
    return PatientModel(
        Id: data['Id'],
        hn: data['HN'],
        Title: data['Title'],
        RegDt: data['RegDt'],
        Fname: data['Fname'],
        Mname: data['Mname'],
        Lname: data['Lname'],
        TitleEng: data['TitleEng'],
        FnameEng: data['FnameEng'],
        MnameEng: data['MnameEng'],
        LnameEng: data['LnameEng'],
        SSN: data['SSN'],
        DOB: data['DOB'],
        Age: data['Age'],
        Addr1: data['Addr1'],
        Addr2: data['Addr2'],
        Addr3: data['Addr3'],
        Addr4: data['Addr4'],
        Addr5: data['Addr5'],
        Phone1: data['Phone1'],
        Phone2: data['Phone2'],
        Phone3: data['Phone3'],
        Email: data['Email'],
        Gender: data['Gender'],
        MaritalStatus: data['MaritalStatus'],
        OccupationId: data['OccupationId'],
        Nationality: data['Nationality'],
        PassportNo: data['PassportNo'],
        BloodGroup: data['BloodGroup'],
        Religion: data['Religion'],
        PatientType: data['PatientType'],
        BlockPatient: data['BlockPatient'],
        EmContactPerson: data['EmContactPerson'],
        EmRelation: data['EmRelation'],
        EmAddr: data['EmAddr'],
        EmPhone: data['EmPhone'],
        InsuranceType: data['InsuranceType'],
        Hl7Format: data['Hl7Format'],
        Hl7Send: data['Hl7Send'],
        LinkDown: data['LinkDown'],
        Allergies: data['Allergies'],
        IsDeleted: data['IsDeleted'],
        IsUpdated: data['IsUpdated'],
        Picture: data['Picture'],
        PictureName: data['PictureName'],
        IsJohndoe: data['IsJohndoe'],
        IsPregnant: data['IsPregnant'],
        IsForeigner: data['IsForeigner'],
        IsVip: data['IsVip'],
        HisHn: data['HisHn'],
        ExtHn: data['ExtHn'],
        OrgId: data['OrgId'],
        CreatedBy: data['CreatedBy'],
        CreatedOn: data['CreatedOn'],
        LastModifiedBy: data['LastModifiedBy'],
        LastModifiedOn: data['LastModifiedOn'],
        Occupation: data['Occupation']);
  }
  PatientModel.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        hn = json['HN'],
        Title = json['Title'],
        RegDt = json['RegDt'] != null
            ? DateTime.parse(json['RegDt'])
            : json['RegDt'],
        Fname = json['Fname'],
        Mname = json['Mname'],
        Lname = json['Lname'],
        TitleEng = json['TitleEng'],
        FnameEng = json['FnameEng'],
        MnameEng = json['MnameEng'],
        LnameEng = json['LnameEng'],
        SSN = json['SSN'],
        DOB = json['DOB'] != null
            ? DateTime.parse(json['DOB']).toLocal()
            : json['DOB'],
        Age = json['Age'],
        Addr1 = json['Addr1'],
        Addr2 = json['Addr2'],
        Addr3 = json['Addr3'],
        Addr4 = json['Addr4'],
        Addr5 = json['Addr5'],
        Phone1 = json['Phone1'],
        Phone2 = json['Phone2'],
        Phone3 = json['Phone3'],
        Email = json['Email'],
        Gender = json['Gender'],
        MaritalStatus = json['MaritalStatus'],
        OccupationId = json['OccupationId'],
        Nationality = json['Nationality'],
        PassportNo = json['PassportNo'],
        BloodGroup = json['BloodGroup'],
        Religion = json['Religion'],
        PatientType = json['PatientType'],
        BlockPatient = json['BlockPatient'],
        EmContactPerson = json['EmContactPerson'],
        EmRelation = json['EmRelation'],
        EmAddr = json['EmAddr'],
        EmPhone = json['EmPhone'],
        InsuranceType = json['InsuranceType'],
        Hl7Format = json['Hl7Format'],
        Hl7Send = json['Hl7Send'],
        LinkDown = json['LinkDown'],
        Allergies = json['Allergies'],
        IsDeleted = json['IsDeleted'],
        IsUpdated = json['IsUpdated'],
        Picture = json['Picture'],
        PictureName = json['PictureName'],
        IsJohndoe = json['IsJohndoe'],
        IsPregnant = json['IsPregnant'],
        IsForeigner = json['IsForeigner'],
        IsVip = json['IsVip'],
        HisHn = json['HisHn'],
        ExtHn = json['ExtHn'],
        OrgId = json['OrgId'],
        CreatedBy = json['CreatedBy'],
        CreatedOn = json['CreatedOn'] != null
            ? DateTime.parse(json['CreatedOn'])
            : json['CreatedOn'],
        LastModifiedBy = json['LastModifiedBy'],
        LastModifiedOn = json['LastModifiedOn'] != null
            ? DateTime.parse(json['LastModifiedOn'])
            : json['LastModifiedOn'],
        Occupation = json['Occupation'];

  Map<String, Object?> toJson() => {
        'Id': Id,
        'HN': hn,
        'Title': Title,
        'RegDt': RegDt,
        'Fname': Fname,
        'Mname': Mname,
        'Lname': Lname,
        'TitleEng': TitleEng,
        'FnameEng': FnameEng,
        'MnameEng': MnameEng,
        'LnameEng': LnameEng,
        'SSN': SSN,
        'DOB': DOB,
        'Age': Age,
        'Addr1': Addr1,
        'Addr2': Addr2,
        'Addr3': Addr3,
        'Addr4': Addr4,
        'Addr5': Addr5,
        'Phone1': Phone1,
        'Phone2': Phone2,
        'Phone3': Phone3,
        'Email': Email,
        'Gender': Gender,
        'MaritalStatus': MaritalStatus,
        'OccupationId': OccupationId,
        'Nationality': Nationality,
        'PassportNo': PassportNo,
        'BloodGroup': BloodGroup,
        'Religion': Religion,
        'PatientType': PatientType,
        'BlockPatient': BlockPatient,
        'EmContactPerson': EmContactPerson,
        'EmRelation': EmRelation,
        'EmAddr': EmAddr,
        'EmPhone': EmPhone,
        'InsuranceType': InsuranceType,
        'Hl7Format': Hl7Format,
        'Hl7Send': Hl7Send,
        'LinkDown': LinkDown,
        'Allergies': Allergies,
        'IsDeleted': IsDeleted,
        'IsUpdated': IsUpdated,
        'Picture': Picture,
        'PictureName': PictureName,
        'IsJohndoe': IsJohndoe,
        'IsPregnant': IsPregnant,
        'IsForeigner': IsForeigner,
        'IsVip': IsVip,
        'HisHn': HisHn,
        'ExtHn': ExtHn,
        'OrgId': OrgId,
        'CreatedBy': CreatedBy,
        'CreatedOn': CreatedOn,
        'LastModifiedBy': LastModifiedBy,
        'LastModifiedOn': LastModifiedOn,
        'Occupation': Occupation
      };
}
