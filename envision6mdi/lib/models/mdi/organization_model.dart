class Organization {
  int? organizationId;
  String? organizationUid;
  String? organizationName;
  String? organizationAlias;
  String? thirdPartyEncoding;
  String? thirdPartyUrl;
  int? isDeleted;

  Organization(
      {this.organizationId,
      this.organizationUid,
      this.organizationName,
      this.organizationAlias,
      this.thirdPartyEncoding,
      this.thirdPartyUrl,
      this.isDeleted});

  factory Organization.fromMap(Map data) {
    return Organization(
        organizationId: data['OrganizationId'],
        organizationUid: data['OrganizationUid'],
        organizationName: data['OrganizationName'],
        organizationAlias: data['OrganizationAlias'],
        thirdPartyEncoding: data['ThirdPartyEncoding'],
        thirdPartyUrl: data['ThirdPartyUrl'],
        isDeleted: data['IsDeleted']);
  }

  Organization.fromJson(Map<String, dynamic> json)
      : organizationId = json['OrganizationId'],
        organizationUid = json['OrganizationUid'],
        organizationName = json['OrganizationName'],
        organizationAlias = json['OrganizationAlias'],
        thirdPartyEncoding = json['ThirdPartyEncoding'],
        thirdPartyUrl = json['ThirdPartyUrl'],
        isDeleted = json['IsDeleted'];

  Map<String, Object?> toJson() => {
        'OrganizationId': organizationId,
        'OrganizationUid': organizationUid,
        'OrganizationName': organizationName,
        'OrganizationAlias': organizationAlias,
        'ThirdPartyEncoding': thirdPartyEncoding,
        'ThirdPartyUrl': thirdPartyUrl,
        'IsDeleted': isDeleted
      };
}
