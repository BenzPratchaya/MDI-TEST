import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_login_model.dart';
import '../models/mdi/user_model.dart';

class UserPreferences {
  Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userId", user.userId!);
    prefs.setString("userName", user.userName ?? '');
    // prefs.setString("userPwd", user.userPwd ?? '');
    prefs.setString("userTitle", user.userTitle ?? '');
    prefs.setString("userFName", user.userFName ?? '');
    prefs.setString("userMName", user.userMName ?? '');
    prefs.setString("userLName", user.userLName ?? '');
    prefs.setString("userTitleEng", user.userTitleEng ?? '');
    prefs.setString("userFNameEng", user.userFNameEng ?? '');
    prefs.setString("userMNameEng", user.userMNameEng ?? '');
    prefs.setString("userLNameEng", user.userLNameEng ?? '');
    prefs.setInt("isDeleted", user.isDeleted ?? 0);
    prefs.setInt("organizationId", user.organizationId ?? 1);
    return prefs;
  }

  Future<UserLogin> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return UserLogin(
        user: User(
      userId: prefs.getInt("userId"),
      userName: prefs.getString("userName"),
      userTitle: prefs.getString("userTitle"),
      userFName: prefs.getString("userFName"),
      userMName: prefs.getString("userMName"),
      userLName: prefs.getString("userLName"),
      userTitleEng: prefs.getString("userTitleEng"),
      userFNameEng: prefs.getString("userFNameEng"),
      userMNameEng: prefs.getString("userMNameEng"),
      userLNameEng: prefs.getString("userLNameEng"),
      isDeleted: prefs.getInt("isDeleted"),
      organizationId: prefs.getInt("organizationId"),
    ));
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
    prefs.remove("userName");
    // prefs.remove("pwd");
    prefs.remove("userTitle");
    prefs.remove("userFName");
    prefs.remove("userMName");
    prefs.remove("userLName");
    prefs.remove("userTitleEng");
    prefs.remove("userFNameEng");
    prefs.remove("userMNameEng");
    prefs.remove("userLNameEng");
    prefs.remove("isDeleted");
    prefs.remove("organizationId");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    return token;
  }
}

// class StmoPreferences {
//   Future saveStmo(StmoModel stmo) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString("stmo", stmo.toJson().toString());
//     prefs.setInt("stmoId", stmo.stmoId!);
//     prefs.setString("name", stmo.name ?? '');
//     prefs.setString("description", stmo.description ?? '');
//     prefs.setString("sendingFacility", stmo.sendingFacility ?? '');
//     prefs.setString("isVisible", stmo.isVisible ?? '');
//     return prefs;
//   }

//   Future<StmoModel> getStmo() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return StmoModel(
//       stmoId: prefs.getInt("stmoId"),
//       name: prefs.getString("name"),
//       description: prefs.getString("description"),
//       sendingFacility: prefs.getString("sendingFacility"),
//       isVisible: prefs.getString("isVisible"),
//     );
//   }

//   void removeStmo() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     prefs.remove("stmoId");
//     prefs.remove("name");
//     prefs.remove("description");
//     prefs.remove("sendingFacility");
//     prefs.remove("isVisible");
//   }

//   Future<String> getToken(args) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("token")!;
//     return token;
//   }
// }
