class SubLocation {
  int? subLocationId;
  int? locationId;
  String? locationText;
  String? subLocationUid;
  String? subLocationName;
  String? subLocationDesc;
  String? subLocationBuilding;
  String? subLocationFloor;
  String? subLocationRoom;
  String? organizationName;
  int? organizationId;
  int? isDeleted;
  int? createdBy;
  DateTime? createdOn;
  int? modifiedBy;
  DateTime? modifiedOn;

  SubLocation({
    this.subLocationId,
    this.locationId,
    this.locationText,
    this.subLocationUid,
    this.subLocationName,
    this.subLocationDesc,
    this.subLocationBuilding,
    this.subLocationFloor,
    this.subLocationRoom,
    this.isDeleted = 0,
    this.organizationName,
    this.organizationId,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  });

  factory SubLocation.fromMap(Map data) {
    return SubLocation(
      subLocationId: data['SubLocationId'],
      locationId: data['LocationId'],
      subLocationUid: data['SubLocationUid'],
      subLocationName: data['SubLocationName'],
      subLocationDesc: data['SubLocationDesc'],
      subLocationBuilding: data['SubLocationBuilding'],
      subLocationFloor: data['SubLocationFloor'],
      subLocationRoom: data['SubLocationRoom'],
      organizationId: data['OrganizationId'],
      organizationName: data['OrganizationName'],
      isDeleted: data['IsDeleted'],
      createdBy: data['CreatedBy'],
      createdOn: data['CreatedOn'],
      modifiedBy: data['ModifiedBy'],
      modifiedOn: data['ModifiedOn'],
    );
  }

  SubLocation.fromJson(Map<String, dynamic> json)
      : subLocationId = json['SubLocationId'],
        locationId = json['LocationId'],
        locationText = json['LocationText'],
        subLocationUid = json['SubLocationUid'],
        subLocationName = json['SubLocationName'],
        subLocationDesc = json['SubLocationDesc'],
        subLocationBuilding = json['SubLocationBuilding'],
        subLocationFloor = json['SubLocationFloor'],
        subLocationRoom = json['SubLocationRoom'],
        isDeleted = json['IsDeleted'],
        organizationName = json['OrganizationName'],
        organizationId = json['OrganizationId'],
        createdBy = json['CreatedBy'],
        createdOn = json['CreatedOn'] != null
            ? DateTime.parse(json['CreatedOn'])
            : json['CreatedOn'],
        modifiedBy = json['ModifiedBy'],
        modifiedOn = json['ModifiedOn'] != null
            ? DateTime.parse(json['ModifiedOn'])
            : json['ModifiedOn'];

  Map<String, Object?> toJson() => {
        'SubLocationId': subLocationId,
        'LocationId': locationId,
        'SubLocationUid': subLocationUid,
        'SubLocationName': subLocationName,
        'SubLocationDesc': subLocationDesc,
        'SubLocationBuilding': subLocationBuilding,
        'SubLocationFloor': subLocationFloor,
        'SubLocationRoom': subLocationRoom,
        'IsDeleted': isDeleted,
        'ModifiedBy': modifiedBy,
        'OrganizationId': organizationId,
      };
}
