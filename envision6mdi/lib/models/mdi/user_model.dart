class User {
  int? userId;
  String? userUid;
  String? userName;
  String? userPwd;
  String? userType;
  String? userTitle;
  String? userFName;
  String? userMName;
  String? userLName;
  String? userTitleEng;
  String? userFNameEng;
  String? userMNameEng;
  String? userLNameEng;
  int? isDeleted;
  int? organizationId;

  User(
      {this.userId,
      this.userUid,
      this.userName,
      this.userPwd,
      this.userType,
      this.userTitle,
      this.userFName,
      this.userMName,
      this.userLName,
      this.userTitleEng,
      this.userFNameEng,
      this.userMNameEng,
      this.userLNameEng,
      this.isDeleted,
      this.organizationId});

  factory User.fromMap(Map data) {
    return User(
        userId: data['UserId'],
        userUid: data['UserUid'],
        userName: data['UserName'],
        userPwd: data['UserPwd'],
        userType: data['UserType'],
        userTitle: data['UserTitle'],
        userFName: data['UserFName'],
        userMName: data['UserMName'],
        userLName: data['UserLName'],
        userTitleEng: data['UserTitleEng'],
        userFNameEng: data['UserFNameEng'],
        userMNameEng: data['UserMNameEng'],
        userLNameEng: data['UserLNameEng'],
        isDeleted: data['IsDeleted'],
        organizationId: data['OrganizationId']);
  }

  User.fromJson(Map<String, dynamic> json)
      : userId = json['UserId'],
        userUid = json['UserUid'],
        userName = json['UserName'],
        userPwd = json['UserPwd'],
        userType = json['UserType'],
        userTitle = json['UserTitle'],
        userFName = json['UserFName'],
        userMName = json['UserMName'],
        userLName = json['UserLName'],
        userTitleEng = json['UserTitleEng'],
        userFNameEng = json['UserFNameEng'],
        userMNameEng = json['UserMNameEng'],
        userLNameEng = json['UserLNameEng'],
        isDeleted = json['IsDeleted'],
        organizationId = json['OrganizationId'];

  Map<String, Object?> toJson() => {
        'UserId': userId,
        'UserUid': userUid,
        'UserName': userName,
        'UserPwd': userPwd,
        'UserType': userType,
        'UserTitle': userTitle,
        'UserFName': userFName,
        'UserMName': userMName,
        'UserLName': userLName,
        'UserTitleEng': userTitleEng,
        'UserFNameEng': userFNameEng,
        'UserMNameEng': userMNameEng,
        'UserLNameEng': userLNameEng,
        'IsDeleted': isDeleted,
        'OrganizationId': organizationId,
      };
}
