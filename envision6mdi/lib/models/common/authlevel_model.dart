// ignore_for_file: non_constant_identifier_names

class AuthLevelModel {
  int Id;
  String? Code;
  String? Desc;
  String? Text;
  int? SL;
  int? OrgId;
  int? CreatedBy;
  DateTime? CreatedOn;
  int? LastModifiedBy;
  DateTime? LastModifiedOn;

  AuthLevelModel(
      {required this.Id,
      this.Code,
      this.Desc,
      this.Text,
      this.SL,
      this.OrgId,
      this.CreatedBy,
      this.CreatedOn,
      this.LastModifiedBy,
      this.LastModifiedOn});

  factory AuthLevelModel.fromMap(Map data) {
    return AuthLevelModel(
        Id: data['Id'],
        Code: data['Code'],
        Desc: data['Desc'],
        Text: data['Text'],
        SL: data['SL'],
        OrgId: data['OrgId'],
        CreatedBy: data['CreatedBy'],
        CreatedOn: data['CreatedOn'],
        LastModifiedBy: data['LastModifiedBy'],
        LastModifiedOn: data['LastModifiedOn']);
  }

  AuthLevelModel.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Code = json['Code'],
        Desc = json['Desc'],
        Text = json['Text'],
        SL = json['SL'],
        OrgId = json['OrgId'],
        CreatedBy = json['CreatedBy'],
        CreatedOn = DateTime.parse(json['CreatedOn']),
        LastModifiedBy = json['LastModifiedBy'],
        LastModifiedOn = DateTime.parse(json['LastModifiedOn']);

  Map<String, Object?> toJson() => {
        'Id': Id,
        'Code': Code,
        'Desc': Desc,
        'Text': Text,
        'SL': SL,
        'OrgId': OrgId,
        'CreatedBy': CreatedBy,
        'CreatedOn': CreatedOn,
        'LastModifiedBy': LastModifiedBy,
        'LastModifiedOn': LastModifiedOn
      };
}
