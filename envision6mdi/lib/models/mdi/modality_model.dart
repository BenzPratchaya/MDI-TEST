// ignore_for_file: prefer_null_aware_operators

class Modality {
  int? modalityId;
  String? modalityUid;
  String? modalityName;
  String? modalityTypeAlias;
  String? modalityHost;

  int? autoConfirm;
  int? isDeleted;

  int? locationId;
  int? subLocationId;
  int? organizationId;
  String? organizationName;
  String? organizationUid;
  String? defaultLocationText;
  String? defaultSubLocationText;
  String? modalityText;
  String? modalityConfig;
  String? modalityLog;
  int? vitalsignInterval;
  String? config;
  int? createBy;
  DateTime? createOn;
  int? modifiedBy;
  DateTime? modifiedOn;

  Modality(
      {this.modalityId,
      this.modalityUid,
      this.modalityName,
      this.modalityTypeAlias,
      this.modalityHost,
      this.autoConfirm = 1,
      this.isDeleted = 0,
      this.locationId,
      this.subLocationId,
      this.organizationId,
      this.organizationName,
      this.organizationUid,
      this.defaultLocationText,
      this.defaultSubLocationText,
      this.modalityText,
      this.modalityConfig,
      this.modalityLog,
      this.vitalsignInterval,
      this.config,
      this.createBy,
      this.createOn,
      this.modifiedBy,
      this.modifiedOn});

  factory Modality.fromMap(Map data) {
    return Modality(
        modalityId: data['ModalityId'],
        modalityUid: data['ModalityUid'],
        modalityName: data['ModalityName'],
        modalityTypeAlias: data['ModalityTypeAlias'],
        modalityHost: data['ModalityHost'],
        autoConfirm: data['AutoConfirm'],
        isDeleted: data['IsDeleted'],
        locationId: data['LocationId'],
        subLocationId: data['SubLocationId'],
        organizationId: data['OrganizationId']);
  }

  Modality.fromJson(Map<String, dynamic> json)
      : modalityId = json['ModalityId'],
        modalityUid = json['ModalityUid'],
        modalityName = json['ModalityName'],
        modalityTypeAlias = json['ModalityTypeAlias'],
        modalityHost = json['ModalityHost'],
        autoConfirm = json['AutoConfirm'],
        isDeleted = json['IsDeleted'],
        locationId = json['LocationId'],
        subLocationId = json['SubLocationId'],
        organizationId = json['OrganizationId'],
        organizationName = json['OrganizationName'],
        defaultLocationText = json['DefaultLocationText'],
        defaultSubLocationText = json['DefaultSubLocationText'],
        modalityText = json['ModalityText'],
        modalityConfig = json['ModalityConfig'],
        modalityLog = json['ModalityLog'],
        vitalsignInterval = json['VitalsignInterval'],
        config = json['Config'],
        modifiedBy = json['ModifiedBy'],
        modifiedOn = json['ModifiedOn'] != null
            ? DateTime.parse(json['ModifiedOn'])
            : json['ModifiedOn'];

  Map<String, Object?> toJson() => {
        // 'ModalityId': modalityId,
        // 'ModalityUid': modalityUid,
        // 'ModalityName': modalityName,
        // 'ModalityTypeAlias': modalityTypeAlias,
        // 'ModalityHost': modalityHost,
        // 'AutoConfirm': autoConfirm,
        // 'IsDeleted': isDeleted,
        // 'LocationId': LocationId,
        // 'SubLocationId': SubLocationId,
        // 'OrganizationId': organizationId,
        'ModalityId': modalityId,
        'ModalityUid': modalityUid,
        'ModalityName': modalityName,
        'ModalityTypeAlias': modalityTypeAlias,
        'ModalityHost': modalityHost,
        'ModalityConfig': modalityConfig,
        'ModalityLog': modalityLog,
        'VitalsignInterval': vitalsignInterval,
        'LocationId': locationId,
        'SubLocationId': subLocationId,
        'Config': config,
        'AutoConfirm': autoConfirm,
        'IsDeleted': isDeleted,
        'OrganizationId': organizationId,
        'CreateBy': createBy,
        'CreateOn': createOn == null ? null : createOn?.toIso8601String(),
        'ModifiedBy': modifiedBy,
        'ModifiedOn': modifiedOn == null ? null : modifiedOn?.toIso8601String(),
      };
}
