import 'package:flutter/services.dart';

class UserModel {
  int? id;
  String? empCode;
  String? userName;
  String? securityQuestion;
  String? securityAnswer;
  String? pwd;
  int? unitId;
  int? jobtitleId;
  String? jobType;
  String? salutation;
  String? fname;
  String? mname;
  String? lname;
  String? fullName;
  String? titleEng;
  String? fnameEng;
  String? mnameEng;
  String? lnameEng;
  String? aliasName;
  String? gender;
  String? emailPersonal;
  String? emailOfficial;
  String? phoneHome;
  String? phoneMobile;
  String? phoneOffice;
  String? preferredPhone;
  int? pabxExt;
  String? faxNo;
  DateTime? dob;
  String? bloodGroup;
  int? defaultLang;
  int? religion;
  String? peAddr1;
  String? peAddr2;
  String? peAddr3;
  String? peAddr4;
  int? authLevelId;
  int? reportingTo;
  bool? allowOthersToFinalize;
  DateTime? lastPwdModified;
  DateTime? lastLogin;
  String? cardNo;
  String? placeOfBirth;
  String? nationality;
  String? mStatus;
  int? defaultShiftNo;
  String? imgFileName;
  String? empReportFooter1;
  String? empReportFooter2;
  ByteData? allproperties;
  bool? visible;
  bool? canExceedSchedule;
  bool? isDarkmenu;
  bool? isAccessvip;
  bool? isFellow;
  bool? isNurse;
  bool? isTechnologist;
  bool? isActive;
  bool? supportUser;
  bool? canKillSession;
  bool? isResident;
  bool? isRadiologist;
  String? theme;
  int? lockScreen;
  String? profileLayout;
  String? menuLayout;
  int? orgId;
  int? createdBy;
  DateTime? createdOn;
  int? lastModifiedBy;
  DateTime? lastModifiedOn;

  UserModel({
    this.id,
    this.empCode,
    this.userName,
    this.securityQuestion,
    this.securityAnswer,
    this.pwd,
    this.unitId,
    this.jobtitleId,
    this.jobType,
    this.salutation,
    this.fname,
    this.mname,
    this.lname,
    this.fullName,
    this.titleEng,
    this.fnameEng,
    this.mnameEng,
    this.lnameEng,
    this.aliasName,
    this.gender,
    this.emailPersonal,
    this.emailOfficial,
    this.phoneHome,
    this.phoneMobile,
    this.phoneOffice,
    this.preferredPhone,
    this.pabxExt,
    this.faxNo,
    this.dob,
    this.bloodGroup,
    this.defaultLang,
    this.religion,
    this.peAddr1,
    this.peAddr2,
    this.peAddr3,
    this.peAddr4,
    this.authLevelId,
    this.reportingTo,
    this.allowOthersToFinalize,
    this.lastPwdModified,
    this.lastLogin,
    this.cardNo,
    this.placeOfBirth,
    this.nationality,
    this.mStatus,
    this.defaultShiftNo,
    this.imgFileName,
    this.empReportFooter1,
    this.empReportFooter2,
    this.allproperties,
    this.visible,
    this.canExceedSchedule,
    this.isDarkmenu,
    this.isAccessvip,
    this.isFellow,
    this.isNurse,
    this.isTechnologist,
    this.isActive,
    this.supportUser,
    this.canKillSession,
    this.isResident,
    this.isRadiologist,
    this.theme,
    this.lockScreen,
    this.profileLayout,
    this.menuLayout,
    this.orgId,
    this.createdBy,
    this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      id: data['id'],
      empCode: data['empCode'],
      userName: data['userName'],
      securityQuestion: data['securityQuestion'],
      securityAnswer: data['securityAnswer'],
      pwd: data['pwd'],
      unitId: data['unitId'],
      jobtitleId: data['jobtitleId'],
      jobType: data['jobType'],
      salutation: data['salutation'],
      fname: data['fname'],
      mname: data['mname'],
      lname: data['lname'],
      fullName: data['fullName'],
      titleEng: data['titleEng'],
      fnameEng: data['fnameEng'],
      mnameEng: data['mnameEng'],
      lnameEng: data['lnameEng'],
      aliasName: data['aliasName'],
      gender: data['gender'],
      emailPersonal: data['emailPersonal'],
      emailOfficial: data['emailOfficial'],
      phoneHome: data['phoneHome'],
      phoneMobile: data['phoneMobile'],
      phoneOffice: data['phoneOffice'],
      preferredPhone: data['preferredPhone'],
      pabxExt: data['pabxExt'],
      faxNo: data['faxNo'],
      dob: data['dob'],
      bloodGroup: data['bloodGroup'],
      defaultLang: data['defaultLang'],
      religion: data['religion'],
      peAddr1: data['peAddr1'],
      peAddr2: data['peAddr2'],
      peAddr3: data['peAddr3'],
      peAddr4: data['peAddr4'],
      authLevelId: data['authLevelId'],
      reportingTo: data['reportingTo'],
      allowOthersToFinalize: data['allowOthersToFinalize'],
      lastPwdModified: data['lastPwdModified'],
      lastLogin: data['lastLogin'],
      cardNo: data['cardNo'],
      placeOfBirth: data['placeOfBirth'],
      nationality: data['nationality'],
      mStatus: data['mStatus'],
      defaultShiftNo: data['defaultShiftNo'],
      imgFileName: data['imgFileName'],
      empReportFooter1: data['empReportFooter1'],
      empReportFooter2: data['empReportFooter2'],
      allproperties: data['allproperties'],
      visible: data['visible'],
      canExceedSchedule: data['canExceedSchedule'],
      isDarkmenu: data['isDarkmenu'],
      isAccessvip: data['isAccessvip'],
      isFellow: data['isFellow'],
      isNurse: data['isNurse'],
      isTechnologist: data['isTechnologist'],
      isActive: data['isActive'],
      supportUser: data['supportUser'],
      canKillSession: data['canKillSession'],
      isResident: data['isResident'],
      isRadiologist: data['isRadiologist'],
      theme: data['theme'],
      lockScreen: data['lockScreen'],
      profileLayout: data['profileLayout'],
      menuLayout: data['menuLayout'],
      orgId: data['orgId'],
      createdBy: data['createdBy'],
      createdOn: data['createdOn'],
      lastModifiedBy: data['lastModifiedBy'],
      lastModifiedOn: data['lastModifiedOn'],
    );
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        empCode = json['empCode'],
        userName = json['userName'],
        securityQuestion = json['securityQuestion'],
        securityAnswer = json['securityAnswer'],
        pwd = json['pwd'],
        unitId = json['unitId'],
        jobtitleId = json['jobtitleId'],
        jobType = json['jobType'],
        salutation = json['salutation'],
        fname = json['fname'],
        mname = json['mname'],
        lname = json['lname'],
        fullName = json['fullName'],
        titleEng = json['titleEng'],
        fnameEng = json['fnameEng'],
        mnameEng = json['mnameEng'],
        lnameEng = json['lnameEng'],
        aliasName = json['aliasName'],
        gender = json['gender'],
        emailPersonal = json['emailPersonal'],
        emailOfficial = json['emailOfficial'],
        phoneHome = json['phoneHome'],
        phoneMobile = json['phoneMobile'],
        phoneOffice = json['phoneOffice'],
        preferredPhone = json['preferredPhone'],
        pabxExt = json['pabxExt'],
        faxNo = json['faxNo'],
        dob = DateTime.parse(json['dob']),
        bloodGroup = json['bloodGroup'],
        defaultLang = json['defaultLang'],
        religion = json['religion'],
        peAddr1 = json['peAddr1'],
        peAddr2 = json['peAddr2'],
        peAddr3 = json['peAddr3'],
        peAddr4 = json['peAddr4'],
        authLevelId = json['authLevelId'],
        reportingTo = json['reportingTo'],
        allowOthersToFinalize = json['allowOthersToFinalize'],
        lastPwdModified = DateTime.parse(json['lastPwdModified']),
        lastLogin = DateTime.parse(json['lastLogin']),
        cardNo = json['cardNo'],
        placeOfBirth = json['placeOfBirth'],
        nationality = json['nationality'],
        mStatus = json['mStatus'],
        defaultShiftNo = json['defaultShiftNo'],
        imgFileName = json['imgFileName'],
        empReportFooter1 = json['empReportFooter1'],
        empReportFooter2 = json['empReportFooter2'],
        // allproperties = json['allproperties'],
        visible = json['visible'],
        canExceedSchedule = json['canExceedSchedule'],
        isDarkmenu = json['isDarkmenu'],
        isAccessvip = json['isAccessvip'],
        isFellow = json['isFellow'],
        isNurse = json['isNurse'],
        isTechnologist = json['isTechnologist'],
        isActive = json['isActive'],
        supportUser = json['supportUser'],
        canKillSession = json['canKillSession'],
        isResident = json['isResident'],
        isRadiologist = json['isRadiologist'],
        theme = json['theme'],
        lockScreen = json['lockScreen'],
        profileLayout = json['profileLayout'],
        menuLayout = json['menuLayout'],
        orgId = json['orgId'],
        createdBy = json['createdBy'],
        createdOn = DateTime.parse(json['createdOn']),
        lastModifiedBy = json['lastModifiedBy'],
        lastModifiedOn = DateTime.parse(json['lastModifiedOn']);

  Map<String, Object?> toJson() => {
        'id': id,
        'empCode': empCode,
        'userName': userName,
        'securityQuestion': securityQuestion,
        'securityAnswer': securityAnswer,
        'pwd': pwd,
        'unitId': unitId,
        'jobtitleId': jobtitleId,
        'jobType': jobType,
        'salutation': salutation,
        'fname': fname,
        'mname': mname,
        'lname': lname,
        'fullName': fullName,
        'titleEng': titleEng,
        'fnameEng': fnameEng,
        'mnameEng': mnameEng,
        'lnameEng': lnameEng,
        'aliasName': aliasName,
        'gender': gender,
        'emailPersonal': emailPersonal,
        'emailOfficial': emailOfficial,
        'phoneHome': phoneHome,
        'phoneMobile': phoneMobile,
        'phoneOffice': phoneOffice,
        'preferredPhone': preferredPhone,
        'pabxExt': pabxExt,
        'faxNo': faxNo,
        'dob': dob,
        'bloodGroup': bloodGroup,
        'defaultLang': defaultLang,
        'religion': religion,
        'peAddr1': peAddr1,
        'peAddr2': peAddr2,
        'peAddr3': peAddr3,
        'peAddr4': peAddr4,
        'authLevelId': authLevelId,
        'reportingTo': reportingTo,
        'allowOthersToFinalize': allowOthersToFinalize,
        'lastPwdModified': lastPwdModified,
        'lastLogin': lastLogin,
        'cardNo': cardNo,
        'placeOfBirth': placeOfBirth,
        'nationality': nationality,
        'mStatus': mStatus,
        'defaultShiftNo': defaultShiftNo,
        'imgFileName': imgFileName,
        'empReportFooter1': empReportFooter1,
        'empReportFooter2': empReportFooter2,
        'allproperties': allproperties,
        'visible': visible,
        'canExceedSchedule': canExceedSchedule,
        'isDarkmenu': isDarkmenu,
        'isAccessvip': isAccessvip,
        'isFellow': isFellow,
        'isNurse': isNurse,
        'isTechnologist': isTechnologist,
        'isActive': isActive,
        'supportUser': supportUser,
        'canKillSession': canKillSession,
        'isResident': isResident,
        'isRadiologist': isRadiologist,
        'theme': theme,
        'lockScreen': lockScreen,
        'profileLayout': profileLayout,
        'menuLayout': menuLayout,
        'orgId': orgId,
        'createdBy': createdBy,
        'createdOn': createdOn,
        'lastModifiedBy': lastModifiedBy,
        'lastModifiedOn': lastModifiedOn,
      };
}
