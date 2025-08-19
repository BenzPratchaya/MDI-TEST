// import 'package:envision6mdi/models/_vna_user_model.dart';

import 'mdi/user_model.dart';

class UserLogin {
  User? user;

  UserLogin({this.user});

  factory UserLogin.fromMap(Map data) {
    return UserLogin(
      user: User.fromMap(data['user']),
    );
  }

  UserLogin.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']);

  Map<String, Object?> toJson() => {
        'user': user,
      };
}
