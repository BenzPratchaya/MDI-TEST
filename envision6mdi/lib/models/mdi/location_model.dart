class Location {
  int? locationId;
  String? locationUid;
  String? locationName;
  String? locationDesc;
  int? isDeleted;
  int? organizationId;
  String? organizationName;
  int? createdBy;
  DateTime? createdOn;
  int? modifiedBy;
  DateTime? modifiedOn;

  Location(
      {this.locationId,
      this.locationUid,
      this.locationName,
      this.locationDesc,
      this.isDeleted = 0,
      this.organizationId,
      this.organizationName,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn});

  factory Location.fromMap(Map data) {
    return Location(
      locationId: data['LocationId'],
      locationUid: data['LocationUid'],
      locationName: data['LocationName'],
      locationDesc: data['LocationDesc'],
      isDeleted: data['IsDeleted'],
      organizationId: data['OrganizationId'],
      organizationName: data['OrganizationName'],
      createdBy: data['CreatedBy'],
      createdOn: data['CreatedOn'],
      modifiedBy: data['ModifiedBy'],
      modifiedOn: data['ModifiedOn'],
    );
  }

  Location.fromJson(Map<String, dynamic> json)
      : locationId = json['LocationId'],
        locationUid = json['LocationUid'],
        locationName = json['LocationName'],
        locationDesc = json['LocationDesc'],
        isDeleted = json['IsDeleted'],
        organizationId = json['OrganizationId'],
        organizationName = json['OrganizationName'],
        createdOn = json['CreatedOn'] != null
            ? DateTime.parse(json['CreatedOn'])
            : json['CreatedOn'],
        modifiedBy = json['ModifiedBy'],
        modifiedOn = json['ModifiedOn'] != null
            ? DateTime.parse(json['ModifiedOn'])
            : json['ModifiedOn'];

  Map<String, Object?> toJson() => {
        'LocationId': locationId,
        'LocationUid': locationUid,
        'LocationName': locationName,
        'LocationDesc': locationDesc,
        'IsDeleted': isDeleted,
        'ModifiedBy': modifiedBy,
        'OrganizationId': organizationId,
      };
}
