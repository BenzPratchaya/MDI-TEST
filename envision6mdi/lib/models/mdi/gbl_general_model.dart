class GblGeneralModel {
  int? generalId;
  String? generalUid;
  String? generalName;
  String? generalGroup;
  int? isDefault;
  int? isDeleted;
  int? createdBy;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  bool? isSelected;

  GblGeneralModel(
      {this.generalId,
      this.generalUid,
      this.generalName,
      this.generalGroup,
      this.isDefault,
      this.isDeleted,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.isSelected});

  GblGeneralModel.fromJson(Map<String, dynamic> json) {
    generalId = json['GeneralId'];
    generalUid = json['GeneralUid'];
    generalName = json['GeneralName'];
    generalGroup = json['GeneralGroup'];
    isDefault = json['IsDefault'];
    isDeleted = json['IsDeleted'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    modifiedBy = json['ModifiedBy'];
    modifiedOn = json['ModifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GeneralId'] = generalId;
    data['GeneralUid'] = generalUid;
    data['GeneralName'] = generalName;
    data['GeneralGroup'] = generalGroup;
    data['IsDefault'] = isDefault;
    data['IsDeleted'] = isDeleted;
    data['CreatedBy'] = createdBy;
    data['CreatedOn'] = createdOn;
    data['ModifiedBy'] = modifiedBy;
    data['ModifiedOn'] = modifiedOn;
    return data;
  }
}
